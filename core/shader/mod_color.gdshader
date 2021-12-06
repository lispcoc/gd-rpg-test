shader_type canvas_item;

uniform float mod_h;
uniform float mod_s;
uniform float mod_v;

void fragment(){
  COLOR = texture(TEXTURE, UV); //read from texture
	// hsvに変換
  float r = COLOR.r;
  float g = COLOR.g;
  float b = COLOR.b;
  float max_v = r > g ? r : g;
  max_v = max_v > b ? max_v : b;
  float min_v = r < g ? r : g;
  min_v = min_v < b ? min_v : b;
  float h = max_v - min_v;
  
  if (h > 0.0f) {
    if (max_v == r) {
      h = (g - b) / h;
      if (h < 0.0f) {
        h += 6.0f;
      }
    } else if (max_v == g) {
      h = 2.0f + (b - r) / h;
    } else {
      h = 4.0f + (r - g) / h;
    }
  }
  h /= 6.0f;
  float s = (max_v - min_v);
  if (max_v != 0.0f)
    s /= max_v;
  float v = max_v;

	h += mod_h;
	s += mod_s;
	v += mod_v;

	// rgbに戻す
	if (s > 1.0f) s = 1.0f;
	if (h > 1.0f) h -= 1.0f;
	if (s < 0.0f) s = 0.0f;
	r = v;
	g = v;
	b = v;
	if (s > 0.0f) {
    	h *= 6.0f;
    	int i = int(h);
	    float f = h - float(i);
		if(i == 0) {
            g *= 1.0f - s * (1.0f - f);
            b *= 1.0f - s;
		} else if (i == 1) {
            r *= 1.0f - s * f;
            b *= 1.0f - s;
		} else if (i == 2) {
            r *= 1.0f - s;
            b *= 1.0f - s * (1.0f - f);
		} else if (i == 3) {
            r *= 1.0f - s;
            g *= 1.0f - s * f;
		} else if (i == 4) {
            r *= 1.0f - s * (1.0f - f);
            g *= 1.0f - s;
		} else if (i == 5) {
            g *= 1.0f - s;
            b *= 1.0f - s * f;
		}
	COLOR.r = r;
	COLOR.g = g;
	COLOR.b = b;
	}
}