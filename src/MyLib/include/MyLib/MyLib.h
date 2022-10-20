#ifndef MY_LIB_H
#define MY_LIB_H

namespace MyLib {

/**
 * @brief A simple function to calculate
 *        the sum of two integers.
 *
 * @param[in]  x     The first summand
 * @param[in]  y     The second summand
 *
 * @return     The sum x + y.
 */
int func(int x, int y = 0);

} // namespace MyLib

#endif /* MY_LIB_H */