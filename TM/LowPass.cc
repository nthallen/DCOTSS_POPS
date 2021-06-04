#include "LowPass.h"

const double LowPass::pi = 3.1415926535897932384626;

LowPass::LowPass(uint8_t seconds)
    : period(0), x0(0), y0(0) {
  set_period(seconds);
}

double LowPass::sample(double x1) {
  if (period == 0) return(x1);
  if (isnan(x1)) x1 = 0.;
  double y1 = b1*x1 + b2*x0 - a2*y0;
  y0 = y1;
  x0 = x1;
  return y1;
}

void LowPass::update_filter(uint8_t seconds) {
  period = seconds;
  if (period != 0) {
    double RC = period/(2*pi);
    b1 = b2 = 1/(1+4*RC);
    a2 = (1-4*RC)*b1;
  }
}
