# TCCM-GPU-2022

Advanced Computational Techniques.\
TCCM Erasmus Mundus course

September 26-30, 2022

University of Perugia

## Download/Clone repository

```bash
git clone https://github.com/so07/TCCM-GPU-2022.git
```

## Slides

The slides are available in PDF format
```bash
cd slides
```

## Hands-on Sessions

Hands on sessions will be held on **M100** cluster at CINECA.  
For a detailed guide on M100 cluster see
[here](https://wiki.u-gov.it/confluence/display/SCAIUS/UG3.2%3A+MARCONI100+UserGuide).

In order to login on M100 cluster for the hands-on sessions
A valid username and password are provided during the lesson.


You can connect to a M100 login node using SSH connection:
```
ssh <userid>@login.m100.cineca.it
```
where <userid> is the username assigned to you.

Please complete and compile the exercises on **login node**.  
Once you have completed the exercise you can request a GPU resource on a **compute node** to run it.

If you want to run on a dedicated GPU, ask the scheduler for GPU resourses using:
```
srun -X -t 10 -N 1 -n 4 --mem=8gb --gres=gpu:1 -p m100_sys_test -q qos_test --pty /usr/bin/bash
```
Within this command you reserve a GPU on a compute node for 10 minutes with 4 CPU cores and 8GB of memory 

In order to avoid to repeat the `srun` command you can source the `get_gpu` file located in the root directory of repository
and an alias to the `srun` command is created.  
Therefore , first:
```
source get_gpu
```
Once you have sourced the `get_gpu` file you can simply reserve a GPU with the following alias:
```
get_gpu
```

**NB**: Please do **NOT** use **login node** to run your exercises but use **compute node**.
login node is only used to complete source code and compile it.

## Exercises

A skeleton of exercises are provided.
At the end of course the **solutions** of all exercises are published in the repository.

## Load Environment Modules

You can load and set your environment through module:
```bash
module load hpc-sdk
```
This will set all environment variables (PATH and LD_LIBRARY_PATH) to the NVIDIA HPC SDK which will provide you with compiler and profiling tools for the hands-on sessions.

You can also load, list, inspect or purge the current state of loaded modules through the followin commands:
```bash
module avail # show the full list of available modules
module list # list currently loaded modules
module show <modulename> # inspect setup of a module
module purge # completely unload all loaded modules
```


## **OpenACC** exercises

```bash
cd hands-on/openacc
```

### Complete exercise skeleton

Open the source code and complete the exercise by adding OpenACC directives.

If you prefer to use C/C++ language complete the source file `laplace2d.c`.  
Instead if you prefer to use Fortran launguage complete the source file `laplace2d.F90`.

A Makefile is available to facilitate the compilation process.

If you are a C/C++ user compiles with command:
```
make pgi_c
```

Insted Fortran users should use command:
```
make pgi_f90
```

## **CUDA** exercises

```bash
cd hands-on/cuda
```

At the end of course the solutions of all exercises are published in the repository

You can use both C/C++ and Fortran for CUDA hands-on session.  
For C/C++ exercises you can choose **GNU** or **HPC-SDK** environment.  
If you are a **Fortran** user you have to load **HPC-SDK** environment in order to use CUDA-FORTRAN.

All exercises are skeleton to complete.  
You have to insert CUDA/CUDA-FORTRAN code to complete exercises where you find comment like
```
INSERT CUDA CODE HERE
```

For each exercises a `Makefile` is presented to help you to compile the exercises.

You find proposed exercises in `hands-on/cuda` directory.

1. See and compile **simple examples** in CUDA/CUDA-FORTRAN   
   `VectorAdd`   
   `MatrixAdd`
2. Complete Matrix Multiplication example and annotate kernel performance    
   `MatrixMul`
