from PIL.Image import *
from math import *
import numpy as np 
Image.MAX_IMAGE_PIXELS = 10000000000                                                                                             

def dist(x1, x2, y1, y2):
	return sqrt(pow(x1-x2,2)+pow(y1-y2,2))

def change():
	l=6000
	h=6000
	out= new('RGBA', (l,h),(127,127,127,255))


	lineWidth = 120
	angle = 0
	i=0
	while (angle<6.28):
		for j in range(lineWidth):
			for pos in range (l//2):
				x=(int)(cos(angle+j/5000)*pos)
				y=(int)(sin(angle+j/5000)*pos)
				if j<lineWidth//4:
					Image.putpixel(out,(l//2+x,h//2+y),(0,0,0,255))
				elif j>2*lineWidth//4 :
					Image.putpixel(out,(l//2+x,h//2+y),(70,70,70,255))


		angle=angle+6.28/80
		i=i+1
		print(i)




	Image.save(out,"save.png")


	return 0

def dark(out):
	(l,h)=out.size
	for r in range (l//4):
		color = (int)(np.log2(r+1))
		for x in range(l//2-r//2):
			for y in range (l//2+r//2):
				dist = sqrt(pow(x-(l//2),2)+pow(y-(l//2),2))
				if dist<r and dist >r-1.5:
					Image.putpixel(out,(x,y),(color,color,color,255))
	Image.save(out,"saveDark.png")


def cercle ():
	l=2000
	h=2000
	out= new('RGBA', (l,h),(0,0,0,0))
	for x in range (l):
		for y in range (h):
			dist = sqrt(pow(x-(l//2),2)+pow(y-(l//2),2))
			if dist<l//2-l//100 and dist >l//2-l/20 :
				Image.putpixel(out,(x,y),(0,0,0,255))
	Image.save(out,"cercle.png")
def transparent(img):
	(l,h)=img.size
	out= new('RGBA', (l,h),(0,0,0,0))

	for x in range (l):
		for y in range (h):
			(r,g,b,a)=img.getpixel((x,y))
			Image.putpixel(out,(x,y),(0,0,0,255-r))
	Image.save(out,"saveDark.png")
#change()
#img=open("a.png")
#dark(img)
#transparent(img)
cercle()

