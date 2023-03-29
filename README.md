# mandelbrot-processing
A horribly inefficient mandelbrot renderer made in Processing





  0: Standard mandelbrot
  
  1: Tricorn (Standard, but squares the complex conjugate)
  
  2: Burning Ship (Standard, but takes the absolute value of a and b)
  
  3: A bowl looking thing (Uses the function (a^2 + b) + i(b^2 + a^2 + b) + c)
  
  4: Newton's Method style equation ((z - (z^2 + 1) / (2 * z)))
  
  5: Using Cosines and Sines (z^3 + c * (sin(z) * cos(z + 1)))

  6: An orb thing (a^2 / Re((c^(a+bi))^2) + i * b^2 / Im((c^(a+bi))^2))
  
  7: A moth? (Im((i * (a + bi))^2) + Re(c) - e^b * sin(a) + i(Re((i * (a + bi))^2) + Im(c) - e^b * cos(a)))
  
  8: A circly thing with wings (z^2 + z / (conjugate(c) + 1))
