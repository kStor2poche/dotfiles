function webcam_on
    sudo modprobe v4l2loopback &&
    gphoto2 --stdout --capture-movie | sudo ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 12 -f v4l2 /dev/video0
end
