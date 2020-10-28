import gdown

url = "https://drive.google.com/uc?export=download&id=1_AckYkinAnhqmRQtGsQgUKAnTHxxX5J0"  # change this link if data
# has been changed.
output = "./spider.zip"

gdown.download(url, output, quiet=False)
