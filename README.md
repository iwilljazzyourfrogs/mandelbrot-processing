# mandelbrot-processing
A horribly inefficient mandelbrot renderer made in Processing



  0: Standard mandelbrot
  
  1: Tricorn (Standard, but squares the complex conjugate)
  
  2: Burning Ship (Standard, but takes the absolute value of a and b)
  
  3: "The Bowl" (Uses the function (a^2 + b) + i(b^2 + a^2 + b) + c)
  
  4: Newton's Method style equation ((z - (z^2 + 1) / (2 * z)))
  
  5: Using Cosines and Sines (z^3 + c * (sin(z) + cos(z)) + c)
