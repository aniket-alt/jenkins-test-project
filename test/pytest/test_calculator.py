import sys
import os
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..')))

from calculator import add, subtract, multiply, divide
import pytest

# Addition tests
def test_add_positive_numbers():
    assert add(2, 3) == 5

def test_add_negative_numbers():
    assert add(-2, -3) == -5

def test_add_zero():
    assert add(5, 0) == 5

# Subtraction tests
def test_subtract_positive_numbers():
    assert subtract(10, 4) == 6

def test_subtract_negative_numbers():
    assert subtract(-5, -3) == -2

def test_subtract_zero():
    assert subtract(5, 0) == 5

# Multiplication tests
def test_multiply_positive_numbers():
    assert multiply(3, 4) == 12

def test_multiply_by_zero():
    assert multiply(5, 0) == 0

def test_multiply_negative_numbers():
    assert multiply(-2, 3) == -6

# Division tests
def test_divide_positive_numbers():
    assert divide(10, 2) == 5

def test_divide_by_zero():
    with pytest.raises(ValueError):
        divide(10, 0)

def test_divide_negative_numbers():
    assert divide(-10, 2) == -5