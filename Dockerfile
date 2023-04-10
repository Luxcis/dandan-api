FROM python:3.8 as build

#作者
MAINTAINER Luxcis

#设置工作文件夹
WORKDIR /dandan
#应用构建成功后文件复制到镜像内
COPY dandan.py requirements.txt ./
#创建工作文件夹
RUN pip3 install -r requirements.txt

FROM gcr.io/distroless/python3
COPY --from=build /dandan /
COPY --from=build /usr/local/lib/python3.8/site-packages /usr/local/lib/python3/site-packages
ENV PYTHONPATH=/usr/local/lib/python3/site-packages

#暴露端口,这个端口对应的是服务本身的端口
EXPOSE 2333

#启动容器时的进程
CMD ["dandan.py"]