
def blakly():
    k = 8
    R = 0
    b = 3
    a = [1,1,0,0,1,1,0,0]
    n = 55

    for i in range(k):
        R = 2*R +a[k-1-i] * b 
        R = R % n 
    print(R)

def binary():
    k = 8
    M = 3
    n = 55
    e = [1,1,0,0,1,1,0,0]
    if e[k-1] == 1:
        C = M
    else:
        C = 1
    for i in range(k-1):
        C = C*C % n
        if e[k-2-i] == 1:
            C = (C*M) % n
    print(C)


if __name__ == '__main__':
    print("Binary IS 1 WRONG SHOULD BE 46:")
    binary()
    print("Blakly:")
    blakly()





# Run the program


