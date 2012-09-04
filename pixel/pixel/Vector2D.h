/*
 *  Vector2D.h
 *  Aquapong
 *
 *  Created by Sylvain NOWE on 9/14/08.
 *  Copyright 2008 Storybird. All rights reserved.
 *
 */

#import <math.h> 

class Vector2D
{
public:
	float x, y;
	
	// trivial ctor
	Vector2D() {}
	
	// setting ctor
	Vector2D(const float x0, const float y0): x(x0), y(y0) {}
	
	// array indexing
	float &operator [](unsigned int i) 
	{   return *(&x+i);   }
	
	// array indexing
	const float &operator [](unsigned int i) const 
	{	return *(&x+i);   }  
	
	// function call operator
	void operator ()(const float x0, const float y0) 
	{	x= x0; y= y0;	}
	
	// test for equality
	bool operator==(const Vector2D &v)
	{	return (x==v.x && y==v.y);	}
	
	// test for inequality
	bool operator!=(const Vector2D &v)
	{	return (x!=v.x || y!=v.y);	}
	
	// set to value
	const Vector2D &operator =(const Vector2D &v)
	{	
		x= v.x; y= v.y;			
		return *this;
	}
	
	// negation
	const Vector2D operator -(void) const
	{	return Vector2D(-x, -y);	}
	
	// addition
	const Vector2D operator +(const Vector2D &v) const
	{	return Vector2D(x+v.x, y+v.y);	}
	
	// subtraction
	const Vector2D operator -(const Vector2D &v) const
	{   return Vector2D(x-v.x, y-v.y);	}
	
	// uniform scaling
	const Vector2D operator *(const float num) const
	{
		Vector2D temp(*this);			
		return temp*=num;
	}
	
	// uniform scaling
	const Vector2D operator /(const float num) const
	{
		Vector2D temp(*this);			
		return temp/=num;
	}		
	
	// addition
	const Vector2D &operator +=(const Vector2D &v)
	{
		x+=v.x;	y+=v.y;						
		return *this;
	}
	
	// subtraction
	const Vector2D &operator -=(const Vector2D &v) 
	{ 
		x-=v.x;	y-=v.y;						
		return *this;	
	}
	
	// uniform scaling
	const Vector2D &operator *=(const float num)
	{
		x*=num;	y*=num;										
		return *this;
	}
	
	
	// uniform scaling
	const Vector2D &operator /=(const float num)
	{
		x/=num;	y/=num;										
		return *this;
	}
	
	// dot product
	float dot(const Vector2D &v) const
	{	return x*v.x + y*v.y;	}	

	
	// gets the length of this vector squared
	float length_squared() const
	{	return (float)(this->dot(*this));   }
	
	float manathan_length() const
	{	return fabs(x) + fabs(y);	}
	
	// gets the length of this vector squared
	float SqDstTo(const Vector2D& b) const
	{
		Vector2D tmp = *this - b;
		return (float)(tmp.dot(tmp));
	}
	
	
	
	// gets the length of this vector
	float length() const
	{	return (float)sqrt(this->dot(*this));   }
	
	// normalizes this vector
	void normalize()
	{	*this/=length();	}
	
	// returns the normalized vector
	Vector2D normalized() const
	{   return  *this/length();  }
	
	// reflects this vector about n
	void reflect(const Vector2D &n)
	{
		Vector2D orig(*this);
		project(n);
		*this= *this*2 - orig;
	}
	
	// projects this vector onto v
	void project(const Vector2D &v)
	{	*this= v * (this->dot(v))/(v.dot(v));	}
	
	// returns this vector projected onto v
	Vector2D projected(const Vector2D &v)
	{   return v * (this->dot(v))/(v.dot(v));	}
	
	// computes the angle between 2 arbitrary vectors
	static inline float angle(const Vector2D &v1, const Vector2D &v2)
	{   return acosf((v1.dot(v2)) / (v1.length()*v2.length()));  }
	
	// computes the angle between 2 normalized arbitrary vectors
	static inline float angle_normalized(const Vector2D &v1, const Vector2D &v2)
	{   return acosf(v1.dot(v2));  }
	
	// computes the orientation to the horizontal
	float orientation()
	{   return atan2f(y, x);  }
	

};
