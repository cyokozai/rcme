# NI-DAQmx Python

## 📟 ⁽ ₍ 🐍

---

## はじめに

### NI-DAQmx

> [NI-DAQmx][NI-DAQmx入門]はNational Instruments (NI) 社が提供するデータ取得 (DAQ：Data Acquisition) ソフトウェアです。NIのDAQハードウェアと共に使用され、データ取得、信号生成、タイミング、制御、信号処理などの機能を提供するために設計されており、研究開発や製造の現場で活躍しています。  
> Python パッケージの一つである[nidaqmx][NI-DAQmx Python Documentation]パッケージには、NI-DAQmx ドライバと対話するための Python API (Application Programming Interface) が備わっています。これにより、NI-DAQmx を高度なラッパーとしてPython で実装することができます。  

ちなみに、nidaqmx は CPython 3.8+ と PyPy3 をサポートしており、jitコンパイルによる高速化の恩恵を受けられる。

### Installation

```bash
~$ python -m pip install nidaqmx
```

## 参考文献

1. [NI-DAQmx入門]
2. [NI-DAQmx Python Documentation]
3. [GitHub nidaqmx-python]

[NI-DAQmx Python Documentation]: https://nidaqmx-python.readthedocs.io/en/latest/
[GitHub nidaqmx-python]: https://github.com/ni/nidaqmx-python
[NI-DAQmx入門]: https://www.ni.com/ja/support/documentation/supplemental/06/getting-started-with-ni-daqmx--main-page.html