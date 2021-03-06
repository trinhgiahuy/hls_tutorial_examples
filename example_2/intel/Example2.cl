#include "Example2.h" // DIM_N and DIM_M are defined here

__kernel void Stencil2D(__global float const *restrict memory_in,
                        __global float *restrict memory_out) {

  // Intel is able to pipeline these loops
  // but it performs three loads (one per element)

  for (int i = 1; i < DIM_N - 1; ++i) {
    for (int j = 0; j < DIM_M; ++j) {

      const float above = memory_in[(i - 1) * DIM_M + j];
      const float center = memory_in[i * DIM_M + j];
      const float below = memory_in[(i + 1) * DIM_M + j];

      const float factor = 0.3333f;
      const float average = factor * (above + center + below);

      memory_out[i * DIM_M + j] = average;
    }
  }
}
