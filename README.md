# XLT2webdriver
> parse XLT scripts into JS scripts based on webdriverio APIs

## Usage

```sh
$ git clone --recursive https://github.com/tnguyen14/xlt2webdriver.git
$ npm i
$ cd xlt2webdriver
$ node index.js
```


## Config
Create config file:

```sh
$ cp config.sample.json config.json
```

Example config file:

```json
{
	"dist": "dist"
}
```
Change `dist` to your desired output directory

## Vagrant
Vagrant allows you to run XLT on a Linux virtual machine.

```sh
$ vagrant up
```