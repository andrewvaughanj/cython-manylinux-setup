# cython_main_setup

This repository contains a very simple example that combines Cython with [https://github.com/pypa/manylinux](https://github.com/pypa/manylinux) to create binary Python packages for Python 2.7 -> Python 3.9.

It is used to demonstrate how to work with Cython, `setuptools` and `manylinux` to generate binary packages targeting many Python versions.

## Building

### Requirements

This script will require you to have Docker installed, to allow you to work with the [https://github.com/pypa/manylinux](https://github.com/pypa/manylinux) Docker images. This demo just uses:

* [https://quay.io/repository/pypa/manylinux1_x86_64](https://quay.io/repository/pypa/manylinux1_x86_64)

### `pomona

The source code lives in the `pomona` folder and provides a very simple Python module that simply `meow`s.

The only interesting point is `pomona/__main__.py` that provides a simple `main` to work with the `Pomona` class.
 
### `setup.py`

The `setup.py` included in this repository has two main features:

* It automatically Cythonises and compiles `pomona.pyx` into `pomona.cpython-<VER>-x86_64-linux-gnu.so`
* It provides the definition of a `console_scripts` that wraps the code in `pomona/__main__.py` to automatically generate an executable script called `pomsy` -- the implementation of `pomsy` is automatically crated by `setup.py` from the entry-point of `pomona.__main__:main`

### `scripts/build.sh`

This script simplifies the [`.travis.yml`](https://github.com/pypa/python-manylinux-demo/blob/master/.travis.yml) from [https://github.com/pypa/python-manylinux-demo](https://github.com/pypa/python-manylinux-demo) -- rather than using Travis, it simply calls `docker` with the our given image name (`manylinux1_x86_64`).

### `scripts/build-wheels.sh` 

This is a **direct copy** of:

* [https://github.com/pypa/python-manylinux-demo/blob/master/travis/build-wheels.sh](https://github.com/pypa/python-manylinux-demo/blob/master/travis/build-wheels.sh)

but where the package name has been changed from `python-manylinux-demo` to be `pomona`.

## Using

### Generated wheels

After running:

```bash
./scripts/build.sh
```

it will populate the folder `wheelhouse` with content such as:

```
pomona-0.0.0-cp27-cp27m-manylinux_2_5_x86_64.manylinux1_x86_64.whl
pomona-0.0.0-cp27-cp27mu-manylinux_2_5_x86_64.manylinux1_x86_64.whl
pomona-0.0.0-cp35-cp35m-manylinux_2_5_x86_64.manylinux1_x86_64.whl
pomona-0.0.0-cp36-cp36m-manylinux_2_5_x86_64.manylinux1_x86_64.whl
pomona-0.0.0-cp37-cp37m-manylinux_2_5_x86_64.manylinux1_x86_64.whl
pomona-0.0.0-cp38-cp38-manylinux_2_5_x86_64.manylinux1_x86_64.whl
pomona-0.0.0-cp39-cp39-manylinux_2_5_x86_64.manylinux1_x86_64.whl
```

**because this folder was created by Docker, it is owned by root -- if you want to delete it, use `sudo`**

### Installing

To quickly look at what one of these wheels does, you can do this:

```bash
python3 -m venv venv
source venv/bin/activate
pyver=$(python3 --version | cut -d ' ' -f 2 | cut -d '.' -f 1-2 | sed "s/\.//g")
pip install wheelhouse/pomona-0.0.0-cp${pyver}-cp${pyver}-manylinux_2_5_x86_64.manylinux1_x86_64.whl --force-reinstall
```

After this is done, you should see something like:

```
venv/lib/python3.8/site-packages/pomona/pomona.cpython-38-x86_64-linux-gnu.so
```

(adjusted for your Python version) and

```
venv/bin/pomsy
```

which is the `setuptools`-generated Python main, wrapping the content in `pomona/__main__.py`.


