FROM nvidia/cuda:12.4.1-cudnn-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV CUDA_HOME=/usr/local/cuda
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
ENV PATH=/usr/local/cuda/bin:$PATH

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-dev python3-pip git wget && \
    ln -sf /usr/bin/python3 /usr/bin/python && \
    ln -sf /usr/bin/pip3 /usr/bin/pip && \
    rm -rf /var/lib/apt/lists/*

ENV PIP_BREAK_SYSTEM_PACKAGES=1

RUN pip install --no-cache-dir --upgrade pip setuptools wheel

RUN pip install --no-cache-dir \
    torch==2.6.0 --index-url https://download.pytorch.org/whl/cu124

RUN pip install --no-cache-dir \
    transformers==4.46.0 \
    peft==0.13.0 \
    accelerate==0.34.0 \
    datasets==3.1.0 \
    scipy \
    rich

RUN pip install --no-cache-dir --extra-index-url https://bitsandbytes-wheels.s3.amazonaws.com/cu124/ \
    bitsandbytes>=0.44.0

WORKDIR /orgonomicon

COPY llm/ llm/
COPY examples/capability-benchmark/ examples/capability-benchmark/

RUN python3 -c "import torch; print(f'CUDA: {torch.cuda.is_available()}, Version: {torch.version.cuda}')"

CMD ["python3", "llm/training/finetune/start_deepseek_finetune.py"]
