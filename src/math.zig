const std = @import("std");
const math = std.math;

pub const Vec2f = std.meta.Vector(2, f32);
pub const Vec3 = std.meta.Vector(3, f32);
pub const Vec3f = Vec3;
pub const Vec4 = std.meta.Vector(4, f32);
pub const Vec4f = Vec4;
const zeroVec4: Vec4 = [_]f32{ 0, 0, 0, 0 };
const identVec4: Vec4 = [_]f32{ 0, 0, 0, 1 };
const negX: Vec4 = [_]f32{ -1.0, 1.0, 1.0, 1.0 };
const negY: Vec4 = [_]f32{ 1.0, -1.0, 1.0, 1.0 };
const negZ: Vec4 = [_]f32{ 1.0, 1.0, -1.0, 1.0 };
const identCol0: Vec4 = [_]f32{ 1.0, 0.0, 0.0, 0.0 };
const identCol1: Vec4 = [_]f32{ 0.0, 1.0, 0.0, 0.0 };
const identCol2: Vec4 = [_]f32{ 0.0, 0.0, 1.0, 0.0 };
const identCol3: Vec4 = [_]f32{ 0.0, 0.0, 0.0, 1.0 };

pub const Vec2fA16 = struct {
    value: Vec2f align(16),
};
pub const Vec1fA16 = struct {
    value: f32 align(16),
};
pub const Vec1iA16 = struct {
    value: i32 align(16),
};

pub const PI = 3.141592654;
pub const TWO_PI = 6.283185307;
pub const ONE_OVER_PI = 0.318309886;
pub const ONE_OVER_2PI = 0.159154943;
pub const PI_DIV_TWO = 1.570796327;
pub const PI_DIV_FOUR = 0.785398163;

pub fn toRadians(f: f32) f32 {
    return f * PI / 180.0;
}

pub fn normVec3(x: Vec3) Vec3 {
    return x / @splat(3, magVec3(x));
}

pub fn dotVec3(x: Vec3, y: Vec3) f32 {
    const val = x * y;
    return val[0] + val[1] + val[2];
}

pub fn magVec3(x: Vec3) f32 {
    return @sqrt(f32, dotVec3(x, x));
}

pub fn normVec2f(x: Vec2f) Vec2f {
    return x / @splat(2, magVec2f(x));
}

pub fn dotVec2f(x: Vec2f, y: Vec2f) f32 {
    const val = x * y;
    return val[0] + val[1];
}

pub fn magVec2f(x: Vec2f) f32 {
    return @sqrt(dotVec2f(x, x));
}

pub fn crossVec3(x: Vec3, y: Vec3) Vec3 {
    const x0 = @shuffle(f32, x, undefined, [_]i32{ 1, 2, 0 });
    const x1 = @shuffle(f32, x, undefined, [_]i32{ 2, 0, 1 });
    const y0 = @shuffle(f32, y, undefined, [_]i32{ 2, 0, 1 });
    const y1 = @shuffle(f32, y, undefined, [_]i32{ 1, 2, 0 });
    return x0 * y0 - x1 * y1;
}

pub const Mat4x4Packed = Mat4x4Data;
const Mat4x4Data = extern union {
    vecs: [4]Vec4,
    elems: [4][4]f32,

    pub fn setVecs(v1: Vec4, v2: Vec4, v3: Vec4, v4: Vec4) Mat4x4Data {
        return Mat4x4Data{
            .vecs = [4]Vec4{
                v1, v2, v3, v4,
            },
        };
    }

    pub fn setElems(e: [16]f32) Mat4x4Data {
        var d: Mat4x4Data = undefined;
        @memcpy(@ptrCast([*]u8, &d.elems), @ptrCast([*]const u8, &e), @sizeOf(@TypeOf(e)));
        return d;
    }
};

var matrixPrintBuf = [_]u8{0} ** 256;

pub const Mat4x4 = struct {
    _data: Mat4x4Data,

    pub fn createZeroed() Mat4x4 {
        return Mat4x4{
            ._data = Mat4x4Data.setVecs(zeroVec4, zeroVec4, zeroVec4, zeroVec4),
        };
    }

    pub fn createIdentity() Mat4x4 {
        return Mat4x4{
            ._data = Mat4x4Data.setVecs(identCol0, identCol1, identCol2, identCol3),
        };
    }

    pub fn createWithElems(elems: [16]f32) Mat4x4 {
        return Mat4x4{
            ._data = Mat4x4Data.setElems(elems),
        };
    }

    pub fn setVecs(a: Vec4, b: Vec4, c: Vec4, d: Vec4) Mat4x4 {
        return Mat4x4{
            ._data = Mat4x4Data.setVecs(a, b, c, d),
        };
    }

    pub fn add(self: Mat4x4, other: Mat4x4) Mat4x4 {
        return Mat4x4{
            ._data = Mat4x4Data.setVecs(
                self.vecs[0] + other.vecs[0],
                self.vecs[1] + other.vecs[1],
                self.vecs[2] + other.vecs[2],
                self.vecs[3] + other.vecs[3],
            ),
        };
    }

    pub fn sub(self: Mat4x4, other: Mat4x4) Mat4x4 {
        return Mat4x4{
            ._data = Mat4x4Data.setVecs(
                self.vecs[0] - other.vecs[0],
                self.vecs[1] - other.vecs[1],
                self.vecs[2] - other.vecs[2],
                self.vecs[3] - other.vecs[3],
            ),
        };
    }

    pub fn mul(self: Mat4x4, other: Mat4x4) Mat4x4 {
        const lhs = Mat4x4.transpose(self)._data;
        const rhs = other._data;

        const x0 = lhs.vecs[0] * rhs.vecs[0];
        const x1 = lhs.vecs[1] * rhs.vecs[0];
        const x2 = lhs.vecs[2] * rhs.vecs[0];
        const x3 = lhs.vecs[3] * rhs.vecs[0];

        const c0: Vec4 = [_]f32{
            x0[0] + x0[1] + x0[2] + x0[3],
            x1[0] + x1[1] + x1[2] + x1[3],
            x2[0] + x2[1] + x2[2] + x2[3],
            x3[0] + x3[1] + x3[2] + x3[3],
        };
        const y0 = lhs.vecs[0] * rhs.vecs[1];
        const y1 = lhs.vecs[1] * rhs.vecs[1];
        const y2 = lhs.vecs[2] * rhs.vecs[1];
        const y3 = lhs.vecs[3] * rhs.vecs[1];

        const c1: Vec4 = [_]f32{
            y0[0] + y0[1] + y0[2] + y0[3],
            y1[0] + y1[1] + y1[2] + y1[3],
            y2[0] + y2[1] + y2[2] + y2[3],
            y3[0] + y3[1] + y3[2] + y3[3],
        };

        const z0 = lhs.vecs[0] * rhs.vecs[2];
        const z1 = lhs.vecs[1] * rhs.vecs[2];
        const z2 = lhs.vecs[2] * rhs.vecs[2];
        const z3 = lhs.vecs[3] * rhs.vecs[2];

        const c2: Vec4 = [_]f32{
            z0[0] + z0[1] + z0[2] + z0[3],
            z1[0] + z1[1] + z1[2] + z1[3],
            z2[0] + z2[1] + z2[2] + z2[3],
            z3[0] + z3[1] + z3[2] + z3[3],
        };

        const w0 = lhs.vecs[0] * rhs.vecs[3];
        const w1 = lhs.vecs[1] * rhs.vecs[3];
        const w2 = lhs.vecs[2] * rhs.vecs[3];
        const w3 = lhs.vecs[3] * rhs.vecs[3];

        const c3: Vec4 = [_]f32{
            w0[0] + w0[1] + w0[2] + w0[3],
            w1[0] + w1[1] + w1[2] + w1[3],
            w2[0] + w2[1] + w2[2] + w2[3],
            w3[0] + w3[1] + w3[2] + w3[3],
        };
        return Mat4x4{
            ._data = Mat4x4Data.setVecs(c0, c1, c2, c3),
        };
    }

    pub fn rotateOnAxis(angle: f32, input_axis: Vec3) Mat4x4 {}

    pub fn rotateX(angle: f32) Mat4x4 {
        const sin: f32 = math.sin(angle);
        const cos: f32 = math.cos(angle);

        const row1: Vec4 = [_]f32{ 0.0, cos, -sin, 0.0 };
        const row2: Vec4 = @shuffle(f32, row1, undefined, [_]i32{ 0, 2, 1, 3 }) * negY;

        return Mat4x4{
            ._data = Mat4x4Data{
                .vecs = [_]Vec4{
                    identCol0,
                    row1,
                    row2,
                    identCol3,
                },
            },
        };
    }

    pub fn rotateY(angle: f32) Mat4x4 {
        const sin: f32 = math.sin(angle);
        const cos: f32 = math.cos(angle);

        const row0: Vec4 = [_]f32{ cos, 0.0, sin, 0.0 };
        const row2: Vec4 = @shuffle(f32, row0, undefined, [_]i32{ 2, 1, 0, 3 }) * negX;

        return Mat4x4{
            ._data = Mat4x4Data{
                .vecs = [_]Vec4{
                    row0,
                    identCol1,
                    row2,
                    identCol3,
                },
            },
        };
    }

    pub fn rotateZ(angle: f32) Mat4x4 {
        const sin: f32 = math.sin(angle);
        const cos: f32 = math.cos(angle);
        const row0: Vec4 = [_]f32{ cos, -sin, 0.0, 0.0 };
        const row1: Vec4 = @shuffle(f32, row0, undefined, [_]i32{ 1, 0, 2, 3 }) * negX;

        return Mat4x4{
            ._data = Mat4x4Data{
                .vecs = [_]Vec4{
                    row0,
                    row1,
                    identCol2,
                    identCol3,
                },
            },
        };
    }

    pub fn translateXYZ(x: f32, y: f32, z: f32) Mat4x4 {
        return Mat4x4.setVecs(
            identCol0,
            identCol1,
            identCol2,
            [_]f32{ x, y, z, 1.0 },
        );
    }

    pub fn translateXY(x: f32, y: f32) Mat4x4 {
        return translateXYZ(x, y, 0.0);
    }

    pub fn translateVec2(v2: Vec2f) Mat4x4 {
        return translateXYZ(v2[0], v2[1], 0.0);
    }

    pub fn scaleXYZ(x: f32, y: f32, z: f32) Mat4x4 {
        var mat = createIdentity();
        var d = &mat._data.elems;
        d[0][0] = x;
        d[1][1] = y;
        d[2][2] = z;
        return mat;
    }

    pub fn scaleUni(f: f32) Mat4x4 {
        var mat = createIdentity();
        var d = &mat._data.elems;
        d[0][0] = f;
        d[1][1] = f;
        d[2][2] = f;
        return mat;
    }

    pub fn scaleX(f: f32) Mat4x4 {
        var mat = createIdentity();
        var d = &mat._data.elems;
        d[0][0] = f;
        return mat;
    }

    pub fn scaleY(f: f32) Mat4x4 {
        var mat = createIdentity();
        var d = &mat._data.elems;
        d[1][1] = f;
        return mat;
    }

    pub fn scaleXY(x: f32, y: f32) Mat4x4 {
        var mat = createIdentity();
        var d = &mat._data.elems;
        d[0][0] = x;
        d[1][1] = y;
        return mat;
    }

    pub fn scaleZ(f: f32) Mat4x4 {
        var mat = createIdentity();
        var d = &mat._data.elems;
        d[2][2] = f;
        return mat;
    }

    fn createViewRH(e: Vec3, s: Vec3, u: Vec3, f: Vec3) Mat4x4 {
        const c0: Vec4 = [_]f32{ s[0], u[0], -f[0], 0 };
        const c1: Vec4 = [_]f32{ s[1], u[1], -f[1], 0 };
        const c2: Vec4 = [_]f32{ s[2], u[2], -f[2], 0 };
        const c3: Vec4 = [_]f32{
            -dotVec3(e, s), -dotVec3(e, u),
            dotVec3(f, e),  1,
        };

        return Mat4x4.setVecs(c0, c1, c2, c3);
    }

    pub fn viewLookAtRH(eye: Vec3, targ: Vec3, up: Vec3) Mat4x4 {
        const f = normVec3(targ - eye); //forward
        const s = normVec3(crossVec3(f, up)); //right
        const u = crossVec3(s, f); //up

        return createViewRH(eye, s, u, f);
    }

    pub fn viewPitchYawRH(eye: Vec3, pitch: f32, yaw: f32) Mat4x4 {
        const cos_pitch = cos(pitch);
        const sin_pitch = sin(pitch);
        const cos_yaw = cos(yaw);
        const sin_yaw = sin(yaw);

        const xaxis: Vec3 = [_]f32{ cos_yaw, 0, -sin_yaw };
        const yaxis: Vec3 = [_]f32{ sin_yaw * sin_pitch, cos_pitch, cos_yaw * sin_pitch };
        const zaxis: Vec3 = [_]f32{ sin_yaw * cos_pitch, -sin_pitch, cos_pitch * cos_yaw };

        return createViewRH(eye, xaxis, yaxis, zaxis);
    }

    pub fn perspectiveRH(width: f32, height: f32, near: f32, far: f32) Mat4x4 {
        const aspect = width / height;
        const range = far / (near - far);
        var mat = Mat4x4.createZeroed();
        var elems = &mat._data.elems;
        elems[0][0] = 1 / aspect;
        elems[1][1] = 1.0;
        elems[2][2] = range;
        elems[2][3] = -1.0;
        elems[3][2] = range * near;
        return mat;
    }

    pub fn orthoRH(left: f32, right: f32, top: f32, bottom: f32, near: f32, far: f32) Mat4x4 {
        const xdiff = right - left;
        const xsum = right + left;
        const ydiff = bottom - top;
        const ysum = bottom + top;
        const ddiff = (far - near);
        var mat = Mat4x4.createZeroed();
        var elems = &mat._data.elems;
        elems[0][0] = 2.0 / xdiff;
        elems[1][1] = 2.0 / ydiff;
        elems[2][2] = 1.0 / ddiff;
        elems[3][0] = -(xsum / xdiff);
        elems[3][1] = -(ysum / ydiff);
        elems[3][2] = near / ddiff;
        elems[3][3] = 1.0;
        return mat;
    }

    pub fn perspectiveFovRH(fov: f32, width: f32, height: f32, near: f32, far: f32) Mat4x4 {
        const f = 1.0 / math.tan(0.5 * fov);
        const aspect = width / height;
        const range = far / (near - far);
        var mat = Mat4x4.createIdentity();
        var elems = &mat._data.elems;
        elems[0][0] = f / aspect;
        elems[1][1] = f;
        elems[2][2] = range;
        elems[2][3] = -1.0;
        elems[3][2] = range * near;
        return mat;
    }
    pub fn transpose(m: Mat4x4) Mat4x4 {
        const d = m._data;
        var c1 = @shuffle(f32, d.vecs[0], d.vecs[1], [_]i32{ 2, 3, ~@as(i32, 2), ~@as(i32, 3) });
        var c2 = @shuffle(f32, d.vecs[2], d.vecs[3], [_]i32{ 2, 3, ~@as(i32, 2), ~@as(i32, 3) });
        var c3 = @shuffle(f32, d.vecs[0], d.vecs[1], [_]i32{ 0, 1, ~@as(i32, 0), ~@as(i32, 1) });
        var c4 = @shuffle(f32, d.vecs[2], d.vecs[3], [_]i32{ 0, 1, ~@as(i32, 0), ~@as(i32, 1) });

        return Mat4x4{
            ._data = Mat4x4Data.setVecs(
                @shuffle(f32, c3, c4, [_]i32{ 0, 2, ~@as(i32, 0), ~@as(i32, 2) }),
                @shuffle(f32, c3, c4, [_]i32{ 1, 3, ~@as(i32, 1), ~@as(i32, 3) }),
                @shuffle(f32, c1, c2, [_]i32{ 0, 2, ~@as(i32, 0), ~@as(i32, 2) }),
                @shuffle(f32, c1, c2, [_]i32{ 1, 3, ~@as(i32, 1), ~@as(i32, 3) }),
            ),
        };
    }

    pub fn inverse(m: Mat4x4) Mat4x4 {
        //const vecs = m._data.vecs;

        //const a = vecs[0].toVector3();
        //const b = vecs[1].toVector3();
        //const c = vecs[2].toVector3();
        //const d = vecs[3].toVector3();

        //const trans = m._data.vecs[3];
        //const x = trans.x;
        //const y = trans.y;
        //const z = trans.z;
        //const w = trans.w;

        //const vadd = Vector3.add;
        //const vdot = Vector3.dot;
        //const vsub = Vector3.sub;
        //const vmuls = Vector3.mulScalar;
        //const vcross = Vector3.cross;
        //var s = vcross(a, b);
        //var t = vcross(c, d);
        //var u = vsub(vmuls(a, y), vmuls(b, x));
        //var v = vsub(vmuls(c, w), vmuls(d, z));

        //const vmulip = Vector3.mulScalarInPlace;
        //const inv_det = 1.0 / (vdot(s,v) + vdot(t,u));
        //vmulip(&s, inv_det);
        //vmulip(&t, inv_det);
        //vmulip(&u, inv_det);
        //vmulip(&v, inv_det);

        //const r0 = vadd(vcross(b, v), vmuls(t, y));
        //const r1 = vsub(vcross(v, a), vmuls(t, x));
        //const r2 = vadd(vcross(d, u), vmuls(s, w));
        //const r3 = vsub(vcross(u, c), vmuls(s, z));

        //return Mat4x4 {
        //    ._data = Mat4x4Data.setElems(
        //        [_]f32 {
        //            r0.x, r0.y, r0.z, -vdot(b, t),
        //            r1.x, r1.y, r1.z, vdot(a, t),
        //            r2.x, r2.y, r2.z, -vdot(d, s),
        //            r3.x, r3.y, r3.z, vdot(c, s)
        //        }
        //    ),
        //};
    }

    pub fn toString(self: *Mat4x4) ![]u8 {
        return std.fmt.bufPrint(
            matrixPrintBuf[0..],
            \\[{}, {}, {}, {}]
            \\[{}, {}, {}, {}]
            \\[{}, {}, {}, {}]
            \\[{}, {}, {}, {}]
        ,
            self._data.elems[0][0],
            self._data.elems[1][0],
            self._data.elems[2][0],
            self._data.elems[3][0],
            self._data.elems[0][1],
            self._data.elems[1][1],
            self._data.elems[2][1],
            self._data.elems[3][1],
            self._data.elems[0][2],
            self._data.elems[1][2],
            self._data.elems[2][2],
            self._data.elems[3][2],
            self._data.elems[0][3],
            self._data.elems[1][3],
            self._data.elems[2][3],
            self._data.elems[3][3],
        );
    }
};
