from __future__ import annotations

import argparse
import csv
import sys
import xml.etree.ElementTree as ET
from datetime import datetime, timezone
from pathlib import Path


OUTPUT_FIELDS = [
    "date",
    "date_sent",
    "readable_date",
    "address",
    "contact_name",
    "type",
    "body",
    "service_center",
]


def format_timestamp(value: str) -> str:
    """Convert an Android SMS timestamp in milliseconds to ISO 8601."""
    try:
        timestamp = int(value) / 1000
    except (TypeError, ValueError):
        return value

    return datetime.fromtimestamp(timestamp, tz=timezone.utc).isoformat()


def parse_sms_backup(xml_path: Path, csv_path: Path) -> int:
    """Parse an SMS backup XML file and write its messages to CSV."""
    try:
        root = ET.parse(xml_path).getroot()
    except (ET.ParseError, OSError) as error:
        raise RuntimeError(f"Could not parse {xml_path}: {error}") from error

    messages = root.findall("sms")
    with csv_path.open("w", newline="", encoding="utf-8-sig") as output_file:
        writer = csv.DictWriter(output_file, fieldnames=OUTPUT_FIELDS)
        writer.writeheader()

        for message in messages:
            row = {field: message.get(field, "") for field in OUTPUT_FIELDS}
            row["date"] = format_timestamp(row["date"])
            row["date_sent"] = format_timestamp(row["date_sent"])
            writer.writerow(row)

    return len(messages)


def main() -> int:
    parser = argparse.ArgumentParser(description="Parse an Android SMS backup XML file.")
    parser.add_argument("xml_file", type=Path, help="Path to the SMS XML file")
    parser.add_argument(
        "-o",
        "--output",
        type=Path,
        help="Output CSV path (default: same name as the XML file)",
    )
    args = parser.parse_args()

    output_path = args.output or args.xml_file.with_suffix(".csv")
    try:
        count = parse_sms_backup(args.xml_file, output_path)
    except RuntimeError as error:
        print(error, file=sys.stderr)
        return 1

    print(f"Wrote {count} SMS messages to {output_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())