FROM nvcr.io/nvidia/l4t-pytorch:r35.1.0-pth1.13-py3
RUN apt-get update
RUN apt-get upgrade -y
RUN echo "python3 -c \"import torch; print('GPU Device name: ' + torch.cuda.get_device_name(0))\"" > start.sh
RUN chmod +x start.sh
CMD ["bash", "start.sh"]
