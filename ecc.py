import numpy as np
import matplotlib.pyplot as plt

class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __eq__(self, other):
        return self.x == other.x and self.y == other.y

    def __neg__(self):
        return Point(self.x, -self.y)

    def __add__(self, other):
        if self == other:
            slope = (3 * self.x**2) / (2 * self.y)
        else:
            slope = (other.y - self.y) / (other.x - self.x)
        x3 = slope**2 - self.x - other.x
        y3 = slope * (self.x - x3) - self.y
        return Point(x3, y3)

    def __mul__(self, n):
        if n == 0:
            return None
        result = None
        addend = self
        for _ in range(n.bit_length()):
            if n & 1:
                result = addend if result is None else result + addend
            addend = addend + addend
            n >>= 1
        return result

    def inverse(self):
        return Point(self.x, -self.y)

# Define the elliptic curve parameters
a = 2
b = 2

# Define the function representing the elliptic curve
def curve_function(x):
    return x**3 + a*x + b

# Define the x values
x_values = np.linspace(-5, 5, 400)
y_values_positive = np.sqrt(np.maximum(0, curve_function(x_values)))
y_values_negative = -np.sqrt(np.maximum(0, curve_function(x_values)))

# Plot the elliptic curve
plt.figure(figsize=(8, 6))
plt.plot(x_values, y_values_positive, label='Curve')
plt.plot(x_values, y_values_negative, label='Curve')

# Define points P and Q
P = Point(2, 2)
Q = Point(3, 1)

# Plot points P and Q
plt.scatter([P.x, Q.x], [P.y, Q.y], color='blue', label='P, Q')

# Point addition
R = P + Q
plt.scatter([R.x], [R.y], color='red', label='P + Q')

# Point multiplication
S = P * 3
plt.scatter([S.x], [S.y], color='green', label='3P')

# Inverse of a point
T = P.inverse()
plt.scatter([T.x], [T.y], color='purple', label='Inverse of P')

plt.title('Elliptic Curve Operations: $y^2 = x^3 + {}x + {}$'.format(a, b))
plt.xlabel('x')
plt.ylabel('y')
plt.grid(True)
plt.axhline(0, color='black',linewidth=0.5)
plt.axvline(0, color='black',linewidth=0.5)
plt.legend()
plt.show()
