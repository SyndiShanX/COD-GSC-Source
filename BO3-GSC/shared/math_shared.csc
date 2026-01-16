/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\math_shared.csc
*************************************************/

#namespace math;

function clamp(val, val_min, val_max) {
  if(val < val_min) {
    val = val_min;
  } else if(val > val_max) {
    val = val_max;
  }
  return val;
}

function linear_map(num, min_a, max_a, min_b, max_b) {
  return clamp((num - min_a) / (max_a - min_a) * (max_b - min_b) + min_b, min_b, max_b);
}

function lag(desired, curr, k, dt) {
  r = 0;
  if((k * dt) >= 1 || k <= 0) {
    r = desired;
  } else {
    err = desired - curr;
    r = curr + ((k * err) * dt);
  }
  return r;
}

function array_average(array) {
  assert(isarray(array));
  assert(array.size > 0);
  total = 0;
  for (i = 0; i < array.size; i++) {
    total = total + array[i];
  }
  return total / array.size;
}

function array_std_deviation(array, mean) {
  assert(isarray(array));
  assert(array.size > 0);
  tmp = [];
  for (i = 0; i < array.size; i++) {
    tmp[i] = (array[i] - mean) * (array[i] - mean);
  }
  total = 0;
  for (i = 0; i < tmp.size; i++) {
    total = total + tmp[i];
  }
  return sqrt(total / array.size);
}

function vector_compare(vec1, vec2) {
  return (abs(vec1[0] - vec2[0])) < 0.001 && (abs(vec1[1] - vec2[1])) < 0.001 && (abs(vec1[2] - vec2[2])) < 0.001;
}

function random_vector(max_length) {
  return (randomfloatrange(-1 * max_length, max_length), randomfloatrange(-1 * max_length, max_length), randomfloatrange(-1 * max_length, max_length));
}

function angle_dif(oldangle, newangle) {
  outvalue = (oldangle - newangle) % 360;
  if(outvalue < 0) {
    outvalue = outvalue + 360;
  }
  if(outvalue > 180) {
    outvalue = (outvalue - 360) * -1;
  }
  return outvalue;
}

function sign(x) {
  if(x >= 0) {
    return 1;
  }
  return -1;
}

function cointoss() {
  return randomint(100) >= 50;
}