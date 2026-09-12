#!/usr/bin/python

############# 06/19/2020 NRK ###########

import numpy as np
import math
import mpmath

def cos_f(a):
  a=a*np.pi/180
  #return "%.10f"%np.cos(a)
  return np.cos(a)
   
    

def sin_f(a):
  a=a*np.pi/180
  #return "%.10f"%-np.sin(a)
  return np.sin(a)

#cos_f(10)
#sin_f(10)

  #d=d*np.pi/180
  # np.cos(d), -np.sin(d), np.cos(2*d), -np.sin(*d), np.cos(3*d), -np.sin(3*d), np.cos(4*d), -np.sin(4*d), 1
  #np.save("/content/drive/My Drive/Colab Notebooks/test/test.out", cos_f(d), sin_f(d), cos_f(2*d), sin_f(2*d), cos_f(3*d), sin_f(3*d), cos_f(4*d), sin_f(4*d),1 ) 
  #np.save("/content/drive/My Drive/Colab Notebooks/test/test2.out", cos_f(d), sin_f(d) ) 
  #print(cos_f(d), sin_f(d), cos_f(2*d), sin_f(2*d), cos_f(3*d), sin_f(3*d), cos_f(4*d), sin_f(4*d),1 ) 

m=[]
for d in range (0,360,10):
  x= [cos_f(d), sin_f(d), cos_f(2*d), sin_f(2*d), cos_f(3*d), sin_f(3*d), cos_f(4*d), sin_f(4*d),1 ]
  m.append(x)

Mat_A = np.array(m)
 
# np.save("/content/drive/My Drive/Colab Notebooks/test/test2.out",y)

print(Mat_A.shape)
print("Mat_A=", Mat_A)

#np.linalg.pinv(Mat_A)
pMat_A = np.linalg.pinv(Mat_A)

print(pMat_A.shape)
print("pMat_A=", pMat_A)


#fileE = open("/content/drive/My Drive/RES/dimeric_force_field/cp_mm_calcs/mm_zeroed/dimer_CC/rotation_alfa/E_QM-MM_zero_refpoint_zero.txt", "r")

#print(fileE.read())
#/content/drive/My Drive/RES/dimeric_force_field/cp_mm_calcs/mm_zeroed/dimer_CC/rotation_alfa/E_QM-MM_zero_refpoint_zero.txt

y=[]
with open("/home/nkumarachchi2019/dimeric_force_field/cp_mm_calcs/mm_zeroed/dimer_CC/rotation_alfa/fitting_data/nk/QM-MM_notor.txt", "r") as file1:
    for line1 in file1:
        #print(line1.split()[1])
        y.append(line1.split()[0])    # [1] column 1 
        #y.append()
        
Mat_Y = np.array(y, dtype=np.float64)

print(Mat_Y.shape)

print("Mat_Y", Mat_Y)
#fileE[1]

Mat_M = pMat_A.dot(Mat_Y)
 
 
print(Mat_M.shape)
print("Mat_M=", Mat_M)
print("Mat_M[0] = e1 =", Mat_M[0])
print("Mat_M[1] = e2 =", Mat_M[1])

#math.degrees(math.atan(Mat_M[0]/Mat_M[1]))   # v1cosp1 / v1 sinP1 = cotP1 , cotinverse 
P1 = math.degrees(mpmath.acot(Mat_M[0]/Mat_M[1]))   # v1cosp1 / v1 sinP1 = cotP1 , cotinverse 
P2 = math.degrees(mpmath.acot(Mat_M[2]/Mat_M[3]))    # v2cosp2 / v2 sinP2 = cotP2 , cotinverse 
P3 = math.degrees(mpmath.acot(Mat_M[4]/Mat_M[5]))      # v3cosp3 / v3 sinP3 = cotP3 , cotinverse 
P4 = math.degrees(mpmath.acot(Mat_M[6]/Mat_M[7]))      # v4cosp4 / v4sinP4 = cotP4 , cotinverse 
Eopt = Mat_M[8]

print("P1=", P1)
print("P2=", P2)
print("P3=", P3)
print("P4=", P4)
print("Eopt=", Eopt)

V1 = Mat_M[0]/np.cos(np.radians(P1))  # e1/cosP1
V2 = Mat_M[2]/np.cos(np.radians(P2))  # e2/cosP2
V3 = Mat_M[4]/np.cos(np.radians(P3))   # e3/cosP3
V4 = Mat_M[6]/np.cos(np.radians(P4))   # e4/cosP4

print("V1=", V1)
print("V2=", V2)
print("V3=", V3)
print("V4=", V4)

print("Mat_M[0] , P1, V1 =" , Mat_M[0] , P1, V1)

print ("cos P1 = ", math.cos(math.radians(11.009597705607833)) )

print( "V1 = e1/cosP1 =  Mat_M[0]/np.cos(np.radians(P1)) =" , Mat_M[0]/np.cos(np.radians(P1)) )




