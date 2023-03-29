int maxIter = 2;

final float originX = -0.45f;
final float originY = -0.55f;
final float radius = 1.5f;

final int choice = 2;

int samples;

boolean rendering = false;
int res = 1;
boolean antiAliasing;

color[] red = {
  color(255, 70, 47), 
  color(236, 77, 55), 
  color(100, 16, 0), 
  color(255, 102, 102), 
  color(255, 153, 102)
};

color[] orange = {
  color(255, 191, 0),
  color(230, 165, 79),
  color(250, 193, 129),
  color(240, 211, 155),
  color(200, 87, 0)
};

color[] yellow = {
  color(255, 255, 153),
  color(255, 255, 102),
  color(255, 255, 0),
  color(255, 204, 0),
  color(235, 163, 0)
};

color[] green = {
  color(24, 74, 35), 
  color(107, 142, 35), 
  color(34, 139, 34), 
  color(50, 205, 50), 
  color(46, 139, 87)
};

color[] cyan = {
  color(0, 255, 255),
  color(64, 224, 208),
  color(70, 130, 180),
  color(0, 128, 128),
  color(47, 79, 79)
};

color[] blue = {
  color(14, 24, 95),
  color(47, 164, 255),
  color(0, 180, 221),
  color(232, 255, 194), 
  color(0, 200, 215)
};

color[] purple = {
  color(81, 47, 107), 
  color(107, 63, 160), 
  color(130, 89, 178), 
  color(163, 121, 194), 
  color(199, 179, 226)
};

color[] pink = {
  color(255, 20, 204), 
  color(255, 191, 191), 
  color(255, 178, 178), 
  color(255, 165, 165), 
  color(255, 153, 153)
};

color[] rainbow = {
  color(255, 0, 0), 
  color(255, 255, 0), 
  color(0, 255, 0),
  color(0, 255, 255),
  color(0, 0, 255),
  color(255, 0, 255)
};

color[] pastel = {
  color(255, 127, 127), 
  color(255, 255, 127), 
  color(127, 255, 127),
  color(127, 255, 255),
  color(127, 127, 255),
  color(255, 127, 255)
};

color[] bw = {
  color(0, 0, 0), 
  color(254, 254, 254),
  color(255, 255, 255)
};

color[] l = {
  color(213, 45, 0), 
  color(239, 118, 39), 
  color(255, 154, 86), 
  color(255, 255, 255), 
  color(209, 98, 164), 
  color(181, 86, 144), 
  color(163, 2, 98)
};

color[] g = {
  color(7,141,112), 
  color(152,232,193), 
  color(255,255,255), 
  color(123,173,226), 
  color(61,26,120)
};

color[] b = {
  color(214, 2, 112), 
  color(155, 79, 150), 
  color(0, 56, 168)
};

color[] t = {
  color(91, 206, 250), 
  color(245, 169, 184),
  color(255, 255, 255),
  color(255, 255, 255),
  color(255, 255, 255), 
  color(245, 169, 184), 
  color(91, 206, 250)
};

color[] colors;

float[][] mandelbrot;

void settings() {
  size(512, 512);
  antiAliasing = false;
  println((int)pow(2, (log(res)/log(2)) + 10));
  if (rendering) {
    size((int)pow(2, (log(res)/log(2)) + 10), (int)pow(2, (log(res)/log(2)) + 10));
    antiAliasing = true;
    maxIter = 512;
    samples = 4;
  }
  mandelbrot = new float[width][height];
}

void setup() {
  color[][] colorOptions = {red, neonPallate(color(255, 0, 0)),           //0, 1
                            orange, neonPallate(color(255, 127, 0)),      //2, 3
                            yellow, neonPallate(color(255, 255, 0)),      //4, 5
                            green, neonPallate(color(0, 255, 0)),         //6, 7
                            cyan, neonPallate(color(0, 255, 255)),        //8, 9
                            blue, neonPallate(color(0, 0, 255)),          //10, 11
                            purple, neonPallate(color(255, 0, 255)),      //12, 13
                            pink, neonPallate(color(255, 0, 110)),        //14, 15
                            rainbow, pastel, bw,                          //16, 17, 18
                            l, g, b, t};                                  //19, 20, 21, 22
  
  String[] colorNames = {"red", "neon_red", 
                         "orange", "neon_orange", 
                         "yellow", "neon_yellow", 
                         "green", "neon_green", 
                         "cyan", "neon_cyan", 
                         "blue", "neon_blue", 
                         "purple", "neon_purple", 
                         "pink", "neon_pink", 
                         "rainbow", "pastel", "bw",
                         "l", "g", "b", "t"};
  
  int selection = 22;
  if (18 < selection && selection < 23) {
    colors = append(reverse(interpolateColors(colorOptions[selection], 100000)), color(0, 0, 0));
  } else {
    colors = append(reverse(interpolateColors(sortColorsB(colorOptions[selection]), 100000)), color(0, 0, 0));
  }
  if (rendering) {
    calculate();
    for (int i = 0; i < colorOptions.length; i++) {
      println(i + "/" + (colorOptions.length - 1));
      colors = append(reverse(interpolateColors(sortColorsB(colorOptions[i]), 100000)), color(0, 0, 0));
      render(colors);
      save("renders/" + choice + "/" + res + "K/" + i + "_" + colorNames[i] + ".png");
    }
    println(int(millis() / 1000.0f) / 60 + ":" + (millis() / 1000.0f) % 60);
    exit();
  }
}

color[] neonPallate(color c) {
  float pc = 0.99;
  return new color[] {color(0), color(red(c) * pc, green(c) * pc, blue(c) * pc), c, color(255)};
}

color[] interpolateColors(color[] colors, int numInterpolations) {
  color[] interpolatedColors = new color[colors.length + numInterpolations * (colors.length - 1)];
  int currentIndex = 0;

  for (int i = 0; i < colors.length - 1; i++) {
    color c1 = colors[i];
    color c2 = colors[i+1];
    float stepR = (red(c2) - red(c1)) / numInterpolations;
    float stepG = (green(c2) - green(c1)) / numInterpolations;
    float stepB = (blue(c2) - blue(c1)) / numInterpolations;

    for (int j = 0; j <= numInterpolations; j++) {
      interpolatedColors[currentIndex++] = color(red(c1) + j * stepR, 
                                                 green(c1) + j * stepG, 
                                                 blue(c1) + j * stepB);
    }
  }

  interpolatedColors[currentIndex] = colors[colors.length - 1];

  return interpolatedColors;
}

color[] sortColorsB(color[] colors) {
  int n = colors.length;
  for (int i = 0; i < n - 1; i++) {
    boolean swapped = false;
    for (int j = 0; j < n - i - 1; j++) {
      if (brightness(colors[j]) < brightness(colors[j+1])) {
        color temp = colors[j];
        colors[j] = colors[j+1];
        colors[j+1] = temp;
        swapped = true;
      }
    }
    if (!swapped) {
      break;
    }
  }
  return colors;
}


void calculate() {
  
  int w = width;
  int h = height;
  
  float minX = (originX - radius);
  float maxX = (originX + radius);
  float minY = (originY - radius);
  float maxY = (originY + radius);
  
  double subPixelSize = (2 * radius) / ((float)w * sqrt(samples)); 
  
  double pixelW = radius / width;
  double pixelH = radius / height;
  
  int sampleW = (int)sqrt(samples);
  
  for (int i = 0; i < w * h; i++) {
    int x = i % w;
    int y = i / w;
    if (rendering) {
      //delay(5);
      if (y % 100 == 0 && x == 0) {
        println(y / (float)h * 100);
      }
    }
    float normalizedN = 0;
    double A = minX + (maxX - minX) / w * x;
    double B = minY + (maxY - minY) / w * y;
    if (antiAliasing) {
      float sum = 0.0f;
      
      for (int j = 0; j < samples; j++) {
        double a = A + subPixelSize * (j % sampleW);
        double b = B + subPixelSize * (int)(j / (double)sampleW);
        
        double ca = a;
        double cb = b;

        float n = 1.0f;
        
        while (n < maxIter) {
          double[] num = function(a, b, new double[] {ca, cb});
          a = num[0];
          b = num[1];

          if (a * a + b * b > 4.0) {
            break;
          }
          n++;
        }
        sum += n;
      }
      normalizedN = log(sum / samples) / log(maxIter);
    } else {
      double a = A;
      a += pixelW / 2;
      double b = B;
      b += pixelH / 2;
      
      double ca = a;
      double cb = b;

      float n = 1.0f;
      while (n < maxIter) {
        double[] num = function(a, b, new double[] {ca, cb});
        a = num[0];
        b = num[1];

        if (a * a + b * b > 4.0) {
          break;
        }
        n++;
      }
      normalizedN = log(n) / log(maxIter);
    }
    mandelbrot[x][y] = normalizedN;
  }
}

void render(color[] cols) {
  int colorsLen = cols.length - 1;
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int colorIndex = (int)(pow(mandelbrot[x][y], 1.5f) * colorsLen);
      color col = colors[colorIndex];
      int index = (x + y * width);
      pixels[index] = col;
    }
  }
  updatePixels();
}

double[] complexPow(double[] z, float n) {
  double r = sqrt((float)(z[0] * z[0] + z[1] * z[1]));
  double theta = atan2((float)(z[1]), (float)(z[0]));
  double real = pow((float)r, (float)n) * cos((float)(n * theta));
  double complex = pow((float)r, (float)n) * sin((float)(n * theta));
  return new double[]{real, complex};
}

double[] complexPow2(double[] z, double[] w) {
  float a = (float)z[0];
  float b = (float)z[1];
  float c = (float)w[0];
  float d = (float)w[1];
  double[] p1 = complexPow(z, c);
  double r = sqrt(a * a + b * b);
  float theta = atan2((float)b, (float)a);
  if (theta < 0) {
    theta += 2 * PI;
  }
  double[] p2 = new double[] {exp(-d * theta) * cos(d * log((float)r)), exp(-d * theta) * sin(d * log((float)r))};
  return new double[] {p1[0] * p2[0] - p1[1] * p2[1], p1[0] * p2[1] + p1[1] * p2[0]};
}

double[] function(double a, double b, double[] c) {
  double[] num = new double[] {a, b};

  final int n = 2;
  double[] temp;
  switch(choice) {
    case(0):
      // Standard
      num = complexPow(num, n);
      num[0] += c[0];
      num[1] += c[1];
      break;
    case(1):
      // tricorn
      num = complexPow(new double[] {a, -b}, n);
      num[0] += c[0];
      num[1] += c[1];
      break;
    case(2):
      // Burning ship
      num[0] = Math.abs(a);
      num[1] = Math.abs(b);
      num = complexPow(num, n);
      num[0] += c[0];
      num[1] += c[1];
      break;
    case(3):
      // (a^2 + b) + i(b^2 + a^2 + b) + c
      num[0] = (num[0] * num[0] + num[1]);
      num[1] = (num[0] + num[1] * num[1]);
      num[0] += c[0];
      num[1] += c[1];
      break;
    case(4):
      // newtons method for f(x)=(z^2+1)
      // (z - (z^2 + 1) / (2 * z))
      num[1] = a * (a*a + b*b + 1) / (2 * (a*a + b*b));
      num[0] = -b * (-a*a - b + 1) / (2 * (a*a + b*b));
      num[0] += c[0];
      num[1] += c[1];
      break;
    case(5):
      // z^3 + c(sin(z) * cos(z) + 1)
      double[] first = complexPow(num, 3);
      double[] second1 = new double[] {(float)Math.sin(a) * (float)Math.cosh(b), 
                                       (float)Math.cos(a) * (float)Math.sinh(b)};
      double[] second2 = new double[] {(float)Math.cos(a) * (float)Math.cosh(b), 
                                       (float)Math.sin(a) * (float)Math.sinh(b)};
      
      double[] second1c = new double[] {c[0] * second1[0] - c[1] * second1[1], 
                                        c[0] * second1[1] + c[1] * second1[0]};
      double[] second2c = new double[] {c[0] * second2[0] - c[1] * second2[1], 
                                        c[0] * second2[1] + c[1] * second2[0]};
      
      num[0] = first[0] + second1c[0] * second2c[0];
      num[1] = first[1] + second1c[1] * second2c[1];
      num[0] += c[0];
      num[1] += c[1];
      break;
      
     case(6):
       temp = complexPow(complexPow2(c, num), n);
       num[0] = a * a / temp[0];
       num[1] = b * b / temp[1];
       break;
       
     case(7):
       double[] p = complexPow(new double[] {b, a}, n);
       num[1] = p[0] + c[1] - (float)(exp((float)b) * cos((float)a));
       num[0] = p[1] + c[0] - (float)(exp((float)b) * sin((float)a));
       break;
       
     case(8):
       temp = complexPow(num, n);
       num[0] = temp[0] + (a * c[0] + a - b * c[1]) / ((c[0] + 1) * (c[0] + 1) + c[1] * c[1]);
       num[1] = temp[1] + (b * c[0] + b + a * c[1]) / ((c[0] + 1) * (c[0] + 1) + c[1] * c[1]);
       break;
  }
  return num;
}

void draw() {
  calculate();
  render(colors);
  maxIter+=10;
  if (maxIter >= 5000) {
    noLoop();
    println("Done!");
  }
}
