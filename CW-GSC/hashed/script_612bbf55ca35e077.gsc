/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_612bbf55ca35e077.gsc
***********************************************/

#namespace namespace_1b041925;

function private preinit() {}

function function_815076cb(keylist, color) {
  foreach(key in keylist) {
    function_b4c6383f(key, 1, color);
  }
}

function function_ed8d6d5e(keylist, startcolor, endcolor, fadetime) {
  foreach(key in keylist) {
    function_b4c6383f(key, 2, startcolor, endcolor, fadetime);
  }
}

function function_119b3b6b(keylist, color, var_276aa694, fadetime, var_109ec056, offset) {
  foreach(key in keylist) {
    function_b4c6383f(key, 4, color, var_276aa694, fadetime, var_109ec056, offset);
  }
}

function function_6f501c4(keylist) {
  foreach(key in keylist) {
    function_5e0ffde3(key);
  }
}