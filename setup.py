from setuptools import setup
from setuptools.extension import Extension
from Cython.Build import cythonize

extensions = [
    Extension(
        "pomona.pomona",
        ["pomona/pomona.pyx"],
    ),
]

setup(
    name="pomona",
    packages=["pomona"],
    ext_modules = cythonize(extensions),
    entry_points = {
        "console_scripts": [
            "pomsy = pomona.__main__:main",
        ]
    }
)

# EOF
