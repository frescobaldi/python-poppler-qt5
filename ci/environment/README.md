This directory contains a lock file that specifies the CI environment used to
build python-poppler-qt5 wheels. This is used to make the build environment
reproducible across CI runs, and makes the CI setup much faster.

The `environment.yml` file contains the names of the packages to be
installed. See [environment-doc] about the format of this file.

The lock file is `conda-lock.yml` and is generated using [conda-lock]. To
regenerate it:

- Install [Miniconda],

- Install conda-lock into the Conda base environment using

  ```
  conda install --channel=conda-forge --name=base conda-lock
  ```

  (you may also create a dedicated environment for it, different than `base`).

- Optional but highly recommended: set the libmamba dependency solver.

  ```
  conda install --channel=conda-forge --name=base conda-libmamba-solver
  conda config --set solver libmamba
  ```

  The dependency resolution takes a lot of time. The libmamba solver is not fast
  (generating the lock file is expected to take several minutes), but it's
  faster than conda's default solver.

- Activate the Conda environment where you installed `conda-lock`, e.g.,

  ```
  conda activate base
  ```

- Run the command `conda-lock`, which updates `conda-lock.yml`.

- Run `conda-lock render` to also update `conda-linux-64.lock`
  from `conda-lock.yml`.

To test your platform's environment locally, first run:

```
conda-lock install --name python-poppler-qt5-test-env conda-lock.yml
```

You may give the environment a different name than
`python-poppler-qt5-test-env`.  Afterwards, activate the newly created
environment with

```
conda activate python-poppler-qt5-test-env
```

(use the environment name you chose)



[environment-doc]: https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#create-env-file-manually
[conda-lock]: https://github.com/conda/conda-lock
[Miniconda]: https://docs.conda.io/en/latest/miniconda.html
