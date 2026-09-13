/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\unittest\ops.gsc
***********************************************/

plus(x, y) {
  z = x + y;
  scripts\unittest\util::test_print(x + " + " + y + " = " + z);
}

minus(x, y) {
  z = x - y;
  scripts\unittest\util::test_print(x + " - " + y + " = " + z);
}

mul(x, y) {
  z = x * y;
  scripts\unittest\util::test_print(x + " * " + y + " = " + z);
}

div(x, y) {
  z = x / y;
  scripts\unittest\util::test_print(x + " / " + y + " = " + z);
}

mod(x, y) {
  z = x % y;
  scripts\unittest\util::test_print(x + " % " + y + " = " + z);
}

eq(x, y, _id_5745C957EC91CC72, _id_0F30DB3A20452FD7) {
  z = x == y;

  if(!isDefined(_id_5745C957EC91CC72))
    _id_5745C957EC91CC72 = x;

  if(!isDefined(_id_0F30DB3A20452FD7))
    _id_0F30DB3A20452FD7 = y;

  scripts\unittest\util::test_print(_id_5745C957EC91CC72 + " == " + _id_0F30DB3A20452FD7 + ": " + z);
}

ne(x, y, _id_5745C957EC91CC72, _id_0F30DB3A20452FD7) {
  z = x != y;

  if(!isDefined(_id_5745C957EC91CC72))
    _id_5745C957EC91CC72 = x;

  if(!isDefined(_id_0F30DB3A20452FD7))
    _id_0F30DB3A20452FD7 = y;

  scripts\unittest\util::test_print(_id_5745C957EC91CC72 + " != " + _id_0F30DB3A20452FD7 + ": " + z);
}

lt(x, y) {
  z = x < y;
  scripts\unittest\util::test_print(x + " < " + y + ": " + z);
}

le(x, y) {
  z = x <= y;
  scripts\unittest\util::test_print(x + " <= " + y + ": " + z);
}

gt(x, y) {
  z = x > y;
  scripts\unittest\util::test_print(x + " > " + y + ": " + z);
}

ge(x, y) {
  z = x >= y;
  scripts\unittest\util::test_print(x + " >= " + y + ": " + z);
}

sl(x, y) {
  z = x << y;
  scripts\unittest\util::test_print(x + " << " + y + " = " + z);
}

sr(x, y) {
  z = x >> y;
  scripts\unittest\util::test_print(x + " >> " + y + " = " + z);
}

limit(_id_AC0E594AC96AA3A8, str) {
  scripts\unittest\util::test_print(_id_AC0E594AC96AA3A8 + " == " + str);
}

binary() {
  plus(0, 1);
  plus(0, -1);
  plus("hi", "bye");
  plus("hi", 0);
  plus(0, 1.0);
  plus(0, -1.0);
  plus((0, 1, 2), (3, 4, 5));
  minus(1, 0);
  minus(0, 1);
  minus(1.0, 0);
  minus(0, 1.0);
  minus((3, 4, 5), (0, 1, 2));
  mul(1, 1);
  mul(1, 0);
  mul(0, 1);
  mul(2, 3);
  mul(2, -1);
  mul(1, 1.0);
  mul(1, 2.0);
  mul(2, -3.0);
  mul((1, 2, 3), (3, 4, 5));
  div(0, 1);
  div(2, 1);
  div(9, 3);
  div(9, 2);
  div(4, -2);
  div(4, 1.0);
  div(5, -1.0);
  div((12, 9, 8), (4, 3, 2));
  mod(0, 1);
  mod(2, 1);
  mod(5, 2);
  mod(5.1, 3.0);
  mod(4.0, 2.0);
  mod(-4.0, 2.0);
  eq(0, 0);
  eq(1, -1);
  eq(3, 4);
  eq(3, 3.0);
  eq(-1, -1);
  eq("hi", "hi1");
  eq("hi", "hi");
  eq((1, 2, 3), (1, 2, 4));
  eq((1, 2, 3), (1, 2, 3));
  eq(::plus, ::plus, "plus", "plus");
  eq(::plus, ::minus, "plus", "minus");
  eq(::allowfire, ::allowfire, "AllowFire", "AllowFire");
  eq(::allowfire, ::allowjump, "AllowFire", "AllowJump");
  ne(0, 0);
  ne(1, -1);
  ne(3, 4);
  ne(3, 3.0);
  ne(-1, -1);
  ne("hi", "hi1");
  ne("hi", "hi");
  ne((1, 2, 3), (1, 2, 4));
  ne((1, 2, 3), (1, 2, 3));
  ne(::plus, ::plus, "plus", "plus");
  ne(::plus, ::minus, "plus", "minus");
  ne(::allowfire, ::allowfire, "AllowFire", "AllowFire");
  ne(::allowfire, ::allowjump, "AllowFire", "AllowJump");
  lt(0, 0);
  lt(0, -1);
  lt(1, 2);
  lt(2, 1);
  lt(1, 2.0);
  lt(1.0, 2);
  lt(3.0, 4.0);
  lt(-3.0, 4.0);
  le(0, 0);
  le(0, -1);
  le(1, 2);
  le(2, 1);
  le(1, 2.0);
  le(1.0, 2);
  le(3.0, 4.0);
  le(-3.0, 4.0);
  gt(0, 0);
  gt(0, -1);
  gt(1, 2);
  gt(2, 1);
  gt(1, 2.0);
  gt(1.0, 2);
  gt(3.0, 4.0);
  gt(-3.0, 4.0);
  ge(0, 0);
  ge(0, -1);
  ge(1, 2);
  ge(2, 1);
  ge(1, 2.0);
  ge(1.0, 2);
  ge(3.0, 4.0);
  ge(-3.0, 4.0);
  sl(0, 0);
  sl(1, 0);
  sl(1, 2);
  sl(2, 2);
  sr(0, 0);
  sr(1, 0);
  sr(1, 2);
  sr(2, 1);
  sr(4, 1);
  limit(0, "0");
  limit(1, "1");
  limit(255, "255");
  limit(-254, "-254");
  limit(-255, "-255");
  limit(65535, "65535");
  limit(-65535, "-65535");
  limit(-65536, "-65536");
  limit(-2147483647, "-2147483647");
  limit(-2147483648, "-2147483648");
  limit(-2147483649, "-2147483649");
  limit(2147483647, "2147483647");
  limit(2147483648, "2147483648");
  limit(-4294967295, "-4294967295");
  limit(-4294967296, "-4294967296");
  limit(-4294967297, "-4294967297");
  limit(4294967295, "4294967295");
  limit(4294967296, "4294967296");
  limit(-9223372036854775807, "-9223372036854775807");
  limit(-9223372036854775808, "-9223372036854775808");
  limit(9223372036854775806, "9223372036854775806");
  limit(9223372036854775807, "9223372036854775807");
}

types() {
  x = 1;
  y = 2;
  _id_CDF8E978F5472D93 = x + y + x;
  scripts\unittest\util::test_print("z0: " + _id_CDF8E978F5472D93);
  _id_CDF8E878F5472B60 = _id_CDF8E978F5472D93 + x + y;
  scripts\unittest\util::test_print("z1: " + _id_CDF8E878F5472B60);
  _id_CDF8EB78F54731F9 = _id_CDF8E878F5472B60 + 1.0;
  scripts\unittest\util::test_print("z2: " + _id_CDF8EB78F54731F9);
  _id_CDF8EA78F5472FC6 = _id_CDF8EB78F54731F9 + "ok";
  scripts\unittest\util::test_print("z3: " + _id_CDF8EA78F5472FC6);
  _id_CDF8ED78F547365F = _id_CDF8EA78F5472FC6 + "bye";
  scripts\unittest\util::test_print("z4: " + _id_CDF8ED78F547365F);
}

main() {
  scripts\unittest\util::test_begin("ops");
  binary();
  types();
  scripts\unittest\util::test_end("ops");
}