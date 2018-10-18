# Order Preserving Dictionary
[![Build Status](https://travis-ci.org/pharo-contributions/OrderPreservingDictionary.svg?branch=master)](https://travis-ci.org/pharo-contributions/OrderPreservingDictionary) [![Coverage Status](https://coveralls.io/repos/github/pharo-contributions/OrderPreservingDictionary/badge.svg?branch=master)](https://coveralls.io/github/pharo-contributions/OrderPreservingDictionary?branch=master)

## Installation

```smalltalk
Metacello new
	baseline: 'OrderPreservingDictionary';
	repository: 'github://pharo-contributions/OrderPreservingDictionary/src';
	load.
```

## Usage

OrderPreservingDictionary preserves the order in which elements were added to to it.

Basic **Dictionary**

```smalltalk
(dict := Dictionary new)
	at: #apple put: 20;
	at: #orange put: 15.

dict keys. "#(#orange #apple)"
```

**OrderPreservingDictionary**

```smalltalk
(dict := OrderPreservingDictionary new)
	at: #apple put: 20;
	at: #orange put: 15.

dict keys. "#(#apple #orange)"
```
