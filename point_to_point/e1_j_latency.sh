#!/bin/bash
##SBATCH -q express
#SBATCH -J JuliaBenchMark
#SBATCH -A hpc-prf-mpibj
#SBATCH -p normal
#SBATCH -N 2                       ## [NUMBER_OF_NODE]
#SBATCH --cpus-per-task=1
#SBATCH --ntasks-per-node=1      ## [NUMBER_OF_MPI_RANKS_PER_NODE]
#SBATCH --exclusive
#SBATCH -t 20:00:00

module reset
module load lang                   # loading the gateway module
module load JuliaHPC               # loading the latest JuliaHPC

srun -n 2 --exclusive julia --project e1_j_latency.jl
srun -n 2 --exclusive /scratch/hpc-prf-mpibj/compa/osu-micro-benchmarks-7.0.1/c/mpi/pt2pt/osu_latency -m 2097152 -i 262144

###ml toolchain intel
####srun -n 160 --exclusive /scratch/hpc-prf-mpibj/com/imb/src_c/IMB-MPI1 allgather -iter 262144 -iter_policy off -npmin 512 -time 72000