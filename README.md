# 拆开看看 · 一甑汾酒是怎么蒸出来的

群核科技 Aholo 全球 3D AI 黑客松参赛作品。

往下滑，把一套古法白酒蒸馏器一层层拆开：灶、底锅、甑箅、甑桶、酒醅、天锅、接酒盘、酒坛。每拆到一个零件，旁边讲它在蒸馏里做什么；可以拖动旋转、点零件看说明。

## 怎么做的

- **8 个零件全部由 Aholo Lux3D 文生 3D 生成**（`G1-Turbo`，带 PBR 材质），一句中文描述一个零件，没有照片、没有手工建模。提示词全文在页面最后一屏和 `index.html` 的 `PARTS` 里。
- 生成脚本：`tools/gen1.sh`、`tools/gen_parts.sh`（调用 Lux3D 官方 OpenAPI 客户端 `manycore-research/Aholo-Lux3D`）。
- 模型用 `gltf-transform` 压缩（WebP 贴图 + meshopt），8 个零件合计约 15MB。
- 网页用 three.js：按尺寸归一化后在浏览器里拼装；滚动驱动拆解、聚焦、镜头；蒸汽、酒滴、酒流是实时粒子；导流管是代码画的。

## 本地运行

```bash
python3 -m http.server 8000   # 然后打开 http://localhost:8000
```

工艺内容出处：汾阳市人民政府「汾酒酿制技艺」介绍、新华网。天锅为古法示意。
