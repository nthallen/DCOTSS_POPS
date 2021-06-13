#ifndef LOWPASS_H_INCLUDED
#define LOWPASS_H_INCLUDED
#include <stdint.h>
#include <math.h>

class LowPass {
  public:
    LowPass(uint8_t seconds);
    inline void set_period(uint8_t seconds) {
      if (period != seconds) update_filter(seconds);
    }
    double sample(double);
  private:
    void update_filter(uint8_t seconds);
    uint8_t period;
    double x0;
    double y0;
    double a2, b1, b2;
    static const double pi;
};

#define LowPassSample(X,Y) X.sample(Y)
#define LowPassSetPeriod(X,Y) X.set_period(Y)
#endif
