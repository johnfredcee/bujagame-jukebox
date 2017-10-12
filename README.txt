"This is meant to be a library for loading and interacting with assets in a iteratively developed lisp game."

Assets are held in another system, located by asdf. The default is bujagame. None of the assets are actually loaded by asdf. This is just to give you a lisp-friendly way of locating your data. I don't think async game asset loading is a use-case of ASDF  :-)
