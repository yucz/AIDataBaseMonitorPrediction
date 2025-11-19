<div align="center">
<h1> AI 数据库监控系统 </h1>

[![License](https://img.shields.io/badge/License-AGPLv3-blue.svg)](LICENSE)
[![Python](https://img.shields.io/badge/python-3.13+-blue.svg)](https://www.python.org/)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.115.4-green.svg)](https://fastapi.tiangolo.com/)
[![Release](https://img.shields.io/github/release/yucz/AIDataBaseMonitorPrediction)](https://github.com/yucz/AIDataBaseMonitorPrediction/releases)
[![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20Linux%20%7C%20macOS-lightgrey.svg)](#-supported-platforms)

**AI 驱动的数据库监控与故障预测系统**

[English](README.md) | [简体中文](README-CN.md)

</div>

---

## 项目概述

### 背景

在数字化转型浪潮中，数据库作为企业数据资产的核心载体，其稳定性和性能直接影响业务连续性。传统数据库监控系统主要依赖基于阈值的告警和可视化图表，存在告警延迟、误报率高、严重依赖运维经验等问题。

随着 AI 技术的快速发展，**AI 数据库监控预测系统**将 DTW（动态时间规整）、FAISS（向量搜索）、LLM（大语言模型）等前沿 AI 方法应用于数据库监控领域，实现从**"被动响应"到"主动预测"**、从**"可视化监控"到"智能运维"**的转变，重新定义数据库管理。

### 创新点

系统创新性地融合了三种 AI 技术：
- **DTW** 用于时间序列模式匹配
- **FAISS** 用于高维向量相似性搜索
- **LLM** 用于智能分析和决策支持

通过多算法融合预测引擎，系统能够**提前 30-60 分钟预测数据库故障**。基于融合算法的预测准确率显著提升，大幅降低数据库运维成本，提高系统可用性。

### 平台介绍

**AI 数据库监控预测系统** 是一个基于人工智能的数据库监控和故障预测平台，为企业数据库基础设施提供实时性能监控、预测分析和智能告警能力。

### 核心特性

- 🤖 **AI 驱动的故障预测** - 提前 1-24 小时预测潜在数据库故障，准确率 >75%
- 📊 **实时监控** - 监控 CPU、内存、磁盘 I/O、连接数和查询性能
- 🔍 **多实例管理** - 同时监控多个数据库实例（MySQL、PostgreSQL）
- 🚨 **智能告警** - 基于预测结果的智能告警，可配置阈值
- 📈 **趋势分析** - 可视化历史性能趋势和异常检测
- 🎯 **自适应融合引擎** - 结合多个 AI 模型以获得最佳预测准确性
- ⚡ **高性能** - 智能缓存机制，响应时间提升 99.9%

---

## 🚀 快速开始

### 下载预编译版本

从 [Releases](https://github.com/your-repo/releases) 下载适合您平台的最新版本：

| 平台 | 文件 | 架构 |
|----------|------|--------------|
| **Windows** | `AIDataBaseMonitor.exe` | x64 |
| **Linux** | `AIDataBaseMonitor` | x64 |
| **macOS** | `AIDataBaseMonitor` | x64/ARM64 |

### 安装步骤

1. **下载** 适合您平台的可执行文件
2. **配置** `.env` 文件（参见 [配置说明](#配置说明)）
3. **运行** 应用程序：

```bash
# Windows
AIDataBaseMonitor.exe

# Linux/macOS
chmod +x AIDataBaseMonitor
./AIDataBaseMonitor
```

4. **访问** Web 界面：`http://localhost:8080`

---

## 💻 支持平台

- **Windows**: Windows 10/11 (x64)
- **Linux**: CentOS 7+, Ubuntu 20.04+ (x64)
- **macOS**: macOS 10.15+ Catalina (x64/ARM64)

---

## 🎯 核心功能

### 1. 实时监控

- **系统指标**：CPU 使用率、内存使用率、磁盘 I/O
- **数据库指标**：连接数、查询响应时间、吞吐量
- **自定义指标**：业务特定的性能指标

### 2. AI 故障预测

- **趋势分析**：基于历史数据的趋势预测
- **异常检测**：智能异常检测，准确率 >75%
- **自适应融合引擎**：结合 DTW、FAISS 和 LLM 预测
- **智能缓存**：重复查询性能提升 99.9%
- **预测时间范围**：提前 1-24 小时预警

### 3. 多实例管理

- **并发监控**：同时监控多个数据库实例
- **数据库支持**：MySQL、PostgreSQL 等主流数据库
- **灵活配置**：可自定义监控间隔和优先级

### 4. 智能告警

- **基于预测的告警**：基于 AI 预测的智能告警
- **可配置阈值**：可自定义告警阈值
- **多种通知渠道**：支持多种通知方式

---

## 🏗️ 技术栈

### 后端技术

- **框架**：FastAPI 0.115.4（高性能异步框架）
- **数据库**：MySQL 5.7+（主数据库）+ Redis 6.0+（缓存）
- **ORM**：SQLAlchemy 2.0.42（异步 ORM）+ Alembic 1.13.1（数据库迁移）
- **AI/ML**：
  - DTW-Python 1.4.0（动态时间规整）
  - FAISS-CPU 1.9.0（向量相似性搜索）
  - OpenAI / DeepSeek（大语言模型）
  - scikit-learn、NumPy、Pandas
  - 自适应融合引擎（自研）

### 前端技术

- **框架**：Vue.js 3（渐进式框架）
- **UI 库**：Element Plus（组件库）
- **可视化**：ECharts（数据可视化）

### 数据源

- **Prometheus**：时序指标
- **MySQL**：历史故障数据
- **Redis**：缓存和消息队列


---

## 📊 系统架构

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│  数据库实例      │    │   Prometheus    │    │   监控数据源     │
│                 │    │                 │    │                 │
└────────┬────────┘    └────────┬────────┘    └────────┬────────┘
         │                      │                      │
         └──────────────────────┼──────────────────────┘
                                │
                   ┌────────────┴────────────┐
                   │      数据采集层          │
                   │                         │
                   └────────────┬────────────┘
                                │
                   ┌────────────┴────────────┐
                   │    AI 预测分析层        │
                   │                         │
                   └────────────┬────────────┘
                                │
                   ┌────────────┴────────────┐
                   │     API 服务层          │
                   │     (FastAPI)           │
                   └────────────┬────────────┘
                                │
                   ┌────────────┴────────────┐
                   │      Web 界面           │
                   │      (Vue.js)           │
                   └─────────────────────────┘
```

---

## ⚙️ 配置说明

### 环境变量配置

编辑与可执行文件同目录下的 `.env` 文件：

```env
# Web 服务器配置
SERVER_PORT=8080                    # 前端访问端口
BACKEND_HOST=127.0.0.1              # 后端 API host
BACKEND_PORT=8000                   # 后端 API 端口

# 应用程序配置
APP_NAME=智能数据库监控系统
APP_VERSION=1.0.0
DEBUG=false                         # 生产环境禁用调试模式
LOG_LEVEL=INFO

# MySQL 配置
MYSQL_HOST=your_mysql_host
MYSQL_PORT=3306
MYSQL_USER=your_username
MYSQL_PASSWORD=your_password
MYSQL_DATABASE=db_prediction

# Redis 配置
REDIS_HOST=your_redis_host
REDIS_PORT=6379
REDIS_DB=0

# Prometheus 配置
PROMETHEUS_URL=http://your_prometheus:9090

# LLM 配置（可选）
LLM_PROVIDER=openai                 # 选项：openai、deepseek、claude
OPENAI_API_KEY=your_api_key
OPENAI_BASE_URL=https://api.openai.com/v1
```

### 系统要求

**最低配置**：
- CPU：2 核心
- 内存：4 GB
- 磁盘：500 MB 可用空间
- 网络：支持 HTTP/HTTPS 访问

**推荐配置**：
- CPU：4+ 核心
- 内存：8+ GB
- 磁盘：2 GB 可用空间（用于日志和缓存）
- 网络：千兆网络

---

## 📚 文档

- [快速开始指南](doc/快速打包参考.md)
- [配置指南](doc/配置说明.md)
- [API 文档](http://localhost:8080/docs)（启动后访问）



## 🐛 故障排查

### 常见问题

1. **启动失败**：检查端口占用和数据库连接
2. **数据采集异常**：验证数据库权限和网络连接
3. **预测结果异常**：检查数据质量和模型状态

### 查看日志

```bash
# 应用日志
tail -f logs/app.log

# 搜索错误
grep "ERROR" logs/app.log
```

---

## 📄 许可证

本项目采用 AGPL-3.0 许可证- 详见 [LICENSE](LICENSE) 文件。

---

## 📧 联系方式

- **Issues**：[GitHub Issues](https://github.com/your-repo/issues)
- **Email**：250305240@qq.com

---

## 🙏 致谢

感谢所有为本项目做出贡献的开发者！

---

<div align="center">

**[⬆ 返回顶部](#-ai-数据库监控系统-)**

Made with ❤️ by the AI Database Monitor Team

</div>

