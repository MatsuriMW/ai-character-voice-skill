# AI 角色语言设计 Skill（yuyan-sheji）

> 人物一开口，露馅最快的就是台词。

律师、修理工、十四岁小孩，模型让他们说同一种客服腔：语法完整、用词中上、礼貌周到、谁说都行。这个 Agent Skill 给每个角色建一份**语言档案**，并在**剧本阶段**就逐人逐句拷打台词，让 AI 短片、短剧里的人说话接近真人。[Claude Code](https://claude.com/claude-code)、Codex、claude.ai 都能用。

[English summary](#english)

## 同一段对白，拷打前后

**沈阳烧烤店老板娘，听说儿子瞒着她辞职、还欠了网贷**

| 改前 | 改后 |
|---|---|
| 我对你的决定感到非常失望。 | 妈呀……你啥时候辞的？ |
| 这真是太让人难过了。 | 先别说还钱。你吃饭没？ |

**曼彻斯特修车行老板，发现儿子瞒着他把车行抵押了**

| 改前 | 改后 |
|---|---|
| I am very disappointed that you did this without telling me. | Bloody hell. You put our place up as security? |
| I understand your feelings, Dad, but it was necessary for the business. | I was trying to keep it open, Dad. I— I thought I could sort it. |

**大阪工厂社长，被东京大客户的女部长通知终止合同**

| 改前 | 改后 |
|---|---|
| 私はあなたの決定に同意できません。 | えっ……ほんまですか。 |
| 我々は二十年間一緒に仕事をしてきたのです。 | 二十年やで。ずっと一緒にやってきたやないですか。 |
| それは酷いです。 | そら、あんまりや……。 |

原稿还有一句「弊社の田中部長はすでに決定なさいました」：对外人抬高自家人，是日语敬语里的内外错误，拷打时直接抓出来。

**架空类明代，草寇拦路**

| 改前 | 改后 |
|---|---|
| 请你们把身上的财物交给我。 | 留下买路财，快些。 |
| 大人，我只是一个农民，我没有钱。 | 大王，小人挑的是菜，身上真没银钱。 |

## 它管什么

三根轴互相独立，组合都成立：

| 轴 | 选项 |
|---|---|
| 语言 | 中文、英文、日语 |
| 时代 | 现代、古代（再定朝代） |
| 风格 | 日语分现实和二次元；古代分考据、通行、戏说；黑帮、JK 这类经典角色分真实、影视、漫画三层 |

| 内容 | 有什么 |
|---|---|
| **日语** | 做日语视频时确保说的是对的：人称表（自称、对称、他称、谦称，标了现实里用不用）；敬语五分类和内外；男女对同辈、上级、下级的对象矩阵；现实已中性化的句末；役割语（大小姐语、老人语、武士语、魔王，おぬし、われ、わらわ）；黑帮、不良、热血少年、JK 的整套语言体系；关西腔（大阪、河内、京都、神户的语法对照，〜はる，词分三层，声调和 TTS 的坑）和其他地方口音；读音表和拍数 |
| **英文** | 英美澳词表和拼写，英国角色过四关；AAVE 语法规则；律师腔；U 和 non-U；夹法语和拉丁语 |
| **中文** | 京味儿、东北话、粤语夹英文、体制内、大厂黑话 |
| **古代** | 中文的帝王、官员、士人、官家女子、平民、商贾、草寇、僧道的称谓和古今替换表；英文的 thou 规矩和摄政时期称呼；日语的时代剧语 |
| **真人感（现代）** | 惊讶、愤怒时脱口而出的话，按语言、年龄、地域、信仰分（bloody hell、oh my goodness、卧槽、这下坏了）；分人群的 filler（like、literally、就是、なんか）和密度 |

## 五个模式

| 模式 | 什么时候用 |
|---|---|
| **R 剧本拷打** | 进分镜之前。逐个人物逼问（他踩到钉子第一个字是什么？），再逐句测（这句换人行不行？真人会说这么完整吗？说给观众听的吗？）。有 10 条出关硬条件 |
| S 从样本建档 | 手上有某人的访谈、口播稿 |
| P 从人设建档 | 手上有人设或小传，可以接[角色设计 skill](https://github.com/MatsuriMW/ai-character-design-skill) |
| W 写或改台词 | 已经有档案 |
| C 检查与回写 | 逐句打标签，把写对的新习惯回写进档案 |

## 评测

都是**模型判模型**，用例和每轮记录在 [`yuyan-sheji/evals/`](yuyan-sheji/evals/)。

**盲测**：四个角色各 3 句，打乱去名，另一个模型只看档案认人。

| 轮次 | 题 | 结果 |
|---|---|---|
| 第一轮（同一会话写台词） | 英文、中文 | 12/12 |
| 第二轮（换人写台词，换模型判卷） | 英文、中文 | 10/12 |
| 第三轮（按认错的句子补档案后） | 英文、中文 | 12/12 |
| 日语 | 现实风格四人 | 12/12 |
| 古代 | 平民、官家女子、官员、草寇 | 12/12 |

**拷打模式从零走**：另一个模型只拿到 skill，处理一段模型写的干净对白。这一项最有用，因为它真的失败过：

| 轮次 | 发现 | 怎么改的 |
|---|---|---|
| 第一轮 | 抓到内外错误，但成品是软的：设定写大阪人却不写大阪腔，没有脱口的话，三个人全程敬体，超长的句子只提醒不改 | 加出关硬条件 |
| 第二轮（中英日、古今四个组合） | 明显变好；但日语从 6 句加到 12 句，加了情节；古代删掉「我父亲是知府」后，下一句「知府千金？」接不上；两处都自评「通过」 | 加「不加戏」「连起来读因果」，要求自评写依据 |
| 第三轮（只跑出问题的两组） | 不再加戏，自己抓到多写的信息并删掉；因果接上了 | |

**脚本**：故意写错的（简体字、二重敬语、「行くですわ」、现实剧里的「おぬし」、古代台词里的「老公」「OK」）都抓到；写对的（言われて、我慢、山田君）不误报。

**这些评测不能说明的**：

- **日语没有经过母语者听校**。审校也是模型做的：低推理一轮报 12 条，确认 10 条；关西腔这份用高推理又审一轮，确信的 8 条都改了。正式发布的日语台词，请母语者听一遍，尤其是关西腔和时代剧语。
- **字写成关西腔，TTS 可能按东京声调念**。这是按引擎工作方式推的，还没有实测过，要自己试听。
- 盲测的角色反差大，题偏容易。
- 脚本查不出敬语方向和内外（最严重的错），这些要逐句人工过。
- 称谓的朝代细节、地域脏话、俚语年份有不少是常识整理，标了〔待核〕，来源和存疑都列在 [`references/sources.md`](yuyan-sheji/references/sources.md)。

## 安装

**推荐度**：★★★ 装上就能用。**依赖**：无；脚本要 Python 3（只用标准库）。

```bash
git clone https://github.com/MatsuriMW/ai-character-voice-skill
cd ai-character-voice-skill
./install.sh            # 装到 ~/.claude/skills（Claude Code）
./install.sh --codex    # 装到 Codex
```

也可以在 [SkillHub](https://skillhub.cn/skills/user_1e879f9b/yuyan-sheji) 搜「语言设计」。

然后说：「帮我拷打一下这段对白」「这个角色怎么说话」「这是古代的官家小姐，帮我写台词」「日语，二次元，傲慢大小姐」。

## 目录

```
yuyan-sheji/
  SKILL.md             入口
  references/          十个维度；语言模式.md；剧本拷打.md；07a 脱口词和 filler
    ja/                日语模式
    era/               时代轴和中英日古代
  templates/           语言档案模板（日语单独一份）、检查报告
  examples/            16 个示例角色
  evals/               用例、盲测题和答案（分开放）、每轮记录
  scripts/yuyan_tool.py  stats、variety、era、ja
```

## 上下游

角色设计（[ai-character-design-skill](https://github.com/MatsuriMW/ai-character-design-skill)）管长相和造型，这里管说话；分镜和配音在 [aigc-skills-and-agents](https://github.com/MatsuriMW/aigc-skills-and-agents)。都是可选的，单独用也行。

## 许可

[CC BY-NC-SA 4.0](LICENSE)：可以用、可以改，署名、非商用、改了要同样开放；用它做出的作品归你。商用请联系作者。

---

<a id="english"></a>

## English

An Agent Skill for Claude Code, Codex and claude.ai that gives each AI-film character a **language profile** and grills the script **before storyboarding**, so a lawyer, a mechanic and a fourteen-year-old stop sharing one customer-service voice.

Three independent axes: **language** (Chinese, English, Japanese), **era** (modern, historical) and **style** (Japanese realistic vs anime; historical accuracy levels). It covers Japanese honorifics and in-group/out-group rules, pronouns by relationship, role language (*yakuwarigo*), classic archetypes such as yakuza and high-school girls; British, American and Australian English, AAVE grammar, class markers; Chinese dialects and historical forms of address; plus what people blurt out when startled and who uses which filler words.

Evaluation is model-on-model: blind speaker identification scored 12/12 on the latest Japanese and historical Chinese sets, and the script-grilling mode failed its first cold run, which is why it now has hard exit criteria. **No native speaker has reviewed the Japanese.** Reference notes are mostly in Chinese.

License: CC BY-NC-SA 4.0.
