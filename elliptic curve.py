import matplotlib.pyplot as plt
import numpy as np

# Parameters for the elliptic curve
a = 2
b = 3
p = 17  # Prime number

# Function to check whether a point (x, y) lies on the elliptic curve
def is_point_on_curve(x, y):
    return (y**2) % p == (x**3 + a*x + b) % p

# Generate points on the elliptic curve
x_values = np.arange(0, p)
y_values_positive = np.sqrt((x_values**3 + a*x_values + b) % p)
y_values_negative = p - np.sqrt((x_values**3 + a*x_values + b) % p)

# Plot the elliptic curve
plt.plot(x_values, y_values_positive, label='Positive square root')
plt.plot(x_values, y_values_negative, label='Negative square root')

# Check and highlight points on the curve
for x in range(p):
    y_positive = np.sqrt((x**3 + a*x + b) % p)
    y_negative = p - np.sqrt((x**3 + a*x + b) % p)
    if is_point_on_curve(x, y_positive):
        plt.scatter(x, y_positive, color='red')
    if is_point_on_curve(x, y_negative):
        plt.scatter(x, y_negative, color='red')

# Set plot labels and legend
plt.title('Elliptic Curve over Finite Field')
plt.xlabel('x')
plt.ylabel('y')
plt.legend()
plt.grid(True)
plt.show()
