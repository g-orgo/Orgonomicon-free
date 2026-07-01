#!/bin/bash
set -e
export PATH=$HOME/.local/bin:$PATH

echo "=== Step 1: Install PyTorch with CUDA ==="
pip install --break-system-packages torch==2.6.0 --index-url https://download.pytorch.org/whl/cu124 2>&1 | tail -5

echo "=== Step 2: Install training dependencies ==="
pip install --break-system-packages \
    transformers==5.12.1 \
    peft==0.19.1 \
    accelerate==1.14.0 \
    datasets==5.0.0 \
    bitsandbytes==0.45.5 \
    scipy \
    rich 2>&1 | tail -5

echo "=== Step 3: Verify CUDA ==="
python3 -c "
import torch
print(f'PyTorch: {torch.__version__}')
print(f'CUDA available: {torch.cuda.is_available()}')
print(f'CUDA version: {torch.version.cuda}')
if torch.cuda.is_available():
    print(f'GPU: {torch.cuda.get_device_name(0)}')
    print(f'VRAM: {torch.cuda.get_device_properties(0).total_memory / 1024**3:.1f} GB')
"

echo "=== Step 4: Verify bitsandbytes ==="
python3 -c "
import bitsandbytes as bnb
print(f'bitsandbytes: {bnb.__version__}')
from transformers import BitsAndBytesConfig
config = BitsAndBytesConfig(load_in_4bit=True, bnb_4bit_quant_type='nf4')
print('BitsAndBytesConfig OK')
"

echo "=== SETUP COMPLETE ==="
