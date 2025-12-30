import json
from pathlib import Path
from PIL import Image

# Rails ルートで実行する想定
BASE_DIR = Path(__file__).resolve().parent.parent
JSON_PATH = BASE_DIR / "tmp" / "marker_jobs.json"


def combine_images_vertically(image_paths, output_path):
    images = [Image.open(p).convert("RGBA") for p in image_paths]

    max_width = max(img.width for img in images)
    total_height = sum(img.height for img in images)

    combined = Image.new("RGBA", (max_width, total_height))

    y_offset = 0
    for img in images:
        combined.paste(img, (0, y_offset))
        y_offset += img.height

    output_path.parent.mkdir(parents=True, exist_ok=True)
    combined.save(output_path)


def main():
    if not JSON_PATH.exists():
        raise FileNotFoundError(f"JSON not found: {JSON_PATH}")

    with open(JSON_PATH, "r", encoding="utf-8") as f:
        jobs = json.load(f)

    for job in jobs:
        image_paths = [BASE_DIR / p for p in job["images"]]
        output_path = BASE_DIR / job["output"]

        # 画像が2枚揃っていない場合はスキップ
        if any(not p.exists() for p in image_paths):
            print(f"Skip (missing image): {output_path}")
            continue

        # すでに生成済みならスキップ
        if output_path.exists():
            print(f"Skip (exists): {output_path}")
            continue

        try:
            combine_images_vertically(image_paths, output_path)
            print(f"Generated: {output_path}")
        except Exception as e:
            print(f"Failed: {output_path} ({e})")

    print("=== Image generation finished ===")


if __name__ == "__main__":
    main()
