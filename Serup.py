from setuptools import setup, find_packages

setup(
    name="DesertEagle",
    version="0.1.0",
    packages=find_packages(where="src"),
    package_dir={"": "src"},
    install_requires=[
        "fastapi",
        "uvicorn",
        "sqlalchemy",
        "redis",
        "tensorflow",
        "transformers",
    ],
    entry_points={
        "console_scripts": [
            "deserteagle-api=src.web.api:main",
        ],
    },
)