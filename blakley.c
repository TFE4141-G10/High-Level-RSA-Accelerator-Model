#include <stdio.h>
#include <stdint.h>

/**
 * @brief   Calculates the modular multiplication a*b mod n 
 *          using the Blakley algorithm
 * 
 * @param a 
 * @param b 
 * @param n 
 * @return  a*b mod n
 */
uint8_t modmul_blakley(uint8_t a, uint8_t b, uint8_t n) {
    uint8_t word_length = 8;
    uint8_t remainder = 0;
    for (uint8_t i = 0; i < word_length; i++) {
        uint8_t bitmask = (1 << (word_length - 1 - i));
        remainder *= 2;
        remainder += ((bitmask & a) && 1)*b;
        remainder %= n;
    }
    return remainder;
}

/**
 * @brief   Calculates the modular exponentiation a^b mod n
 *          using the Left-to-Right binary method
 * 
 * @param a in the case of RSA, this is the message 
 * @param b in the case of RSA, this is the encryption
 * @param n 
 * @return  a^b mod n
 */
uint8_t modexp_binary(uint8_t a, uint8_t b, uint8_t n) {
    uint8_t word_length = 8;
    uint8_t bitmask = (1 << (word_length - 1));
    uint8_t remainder;
    if (bitmask & b) {
        remainder = a;
    } else {
        remainder = 1;
    }
    for (uint8_t i = word_length - 1; i > 0; i--) {
        bitmask = (1 << (i - 1));
        remainder = modmul_blakley(remainder, remainder, n);
        if (bitmask & b) {
            remainder = modmul_blakley(remainder, a, n);
        }
    }
    return remainder;
}

void main() {
    uint8_t a = 51;
    uint8_t b = 3;
    uint8_t n = 5*11;

    printf("modmul expected/actual:\t43/%d\n", modmul_blakley(a, b, n));
    printf("modexp expected/actual:\t46/%d\n", modexp_binary(a, b, n));
}