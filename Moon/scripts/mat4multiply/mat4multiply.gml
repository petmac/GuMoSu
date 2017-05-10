///@desc mat4multiply(a,b,c)
///@arg a argument0;
///@arg b argument1;
///@arg c argument2;

var a = argument0;
var b = argument1;
var c = argument2;

if(!is_matrix(c)) { c=matrix_multiply(a,matrix_build_identity()); } //c || (c = a); ??
var d = a[0];
var e = a[1];
var g = a[2];
var f = a[3];
var h = a[4];
var i = a[5];
var j = a[6];
var k = a[7];
var l = a[8];
var o = a[9];
var m = a[10];
var n = a[11];
var p = a[12];
var r = a[13];
var s = a[14];
a = a[15];
var A = b[0];
var B = b[1];
var t = b[2];
var u = b[3];
var v = b[4];
var w = b[5];
var xx = b[6];
var yy = b[7];
var z = b[8];
var C = b[9];
var D = b[10];
var E = b[11];
var q = b[12];
var F = b[13];
var G = b[14];
b = b[15];
c[0] = A * d + B * h + t * l + u * p;
c[1] = A * e + B * i + t * o + u * r;
c[2] = A * g + B * j + t * m + u * s;
c[3] = A * f + B * k + t * n + u * a;
c[4] = v * d + w * h + xx * l + yy * p;
c[5] = v * e + w * i + xx * o + yy * r;
c[6] = v * g + w * j + xx * m + yy * s;
c[7] = v * f + w * k + xx * n + yy * a;
c[8] = z * d + C * h + D * l + E * p;
c[9] = z * e + C * i + D * o + E * r;
c[10] = z * g + C * j + D * m + E * s;
c[11] = z * f + C * k + D * n + E * a;
c[12] = q * d + F * h + G * l + b * p;
c[13] = q * e + F * i + G * o + b * r;
c[14] = q * g + F * j + G * m + b * s;
c[15] = q * f + F * k + G * n + b * a;
return c;