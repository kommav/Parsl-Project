import parsl
from parsl import python_app

parsl.load()


@python_app
def app_A():
    a = 2 * 3 + 1
    return a


@python_app
def app_B():
    b = 2 + 2 / 2
    return b


@python_app
def app_C(x, y):
    return x + y


total = app_C(app_A(), app_B()).result()

print(total)
# total will be 10
