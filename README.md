<div align="center">
<h1> AI Database Monitor Prediction </h1>

[![License](https://img.shields.io/badge/License-AGPLv3-blue.svg)](LICENSE)
[![Python](https://img.shields.io/badge/python-3.13+-blue.svg)](https://www.python.org/)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.115.4-green.svg)](https://fastapi.tiangolo.com/)
[![Release](https://img.shields.io/github/v/release/yucz/AIDataBaseMonitorPrediction?color=blue&label=Latest%20Release)](https://fastapi.tiangolo.com/)
[![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20Linux%20%7C%20macOS-lightgrey.svg)](#-supported-platforms)

**AI-Powered Database Monitoring and Fault Prediction System**

[English](README.md) | [简体中文](README-CN.md)

</div>

---


## Overview

### Background

Amid the wave of digital transformation, databases—serving as the core carriers of enterprise data assets—directly impact business continuity through their stability and performance. Traditional database monitoring systems primarily rely on threshold-based alerts and visual charts, which suffer from issues such as delayed alerts, high false positive rates, and heavy reliance on operational experience.

With the rapid advancement of AI technologies, **AI Database Monitor Prediction** applies cutting-edge AI methods including DTW (Dynamic Time Warping), FAISS (vector search), and LLM (large language models) to database monitoring, shifting from **"reactive response" to "proactive prediction"** and from **"visualized monitoring" to "intelligent operations"**, thereby redefining database management.

### Innovation

The system innovatively integrates three AI technologies:
- **DTW** for time series pattern matching
- **FAISS** for high-dimensional vector similarity search
- **LLM** for intelligent analysis and decision support

Through a multi-algorithm fusion prediction engine, the system can **predict database failures 30-60 minutes in advance**. The prediction accuracy based on the fusion algorithm is significantly improved, substantially reducing database operational costs and enhancing system availability.

### Platform Overview

**AI Database Monitor Prediction** is an intelligent database monitoring and fault prediction platform powered by artificial intelligence. It provides real-time performance monitoring, predictive analytics, and intelligent alerting capabilities for enterprise database infrastructure.

### Key Features

- 🤖 **AI-Driven Fault Prediction** - Predict potential database failures 1-24 hours in advance with >75% accuracy
- 📊 **Real-Time Monitoring** - Monitor CPU, memory, disk I/O, connections, and query performance
- 🔍 **Multi-Instance Management** - Simultaneously monitor multiple database instances (MySQL, PostgreSQL)
- 🚨 **Intelligent Alerting** - Smart alerts based on prediction results with configurable thresholds
- 📈 **Trend Analysis** - Visualize historical performance trends and anomaly detection
- 🎯 **Adaptive Fusion Engine** - Combine multiple AI models for optimal prediction accuracy
- ⚡ **High Performance** - Smart caching mechanism with 99.9% response time improvement

---

## 🚀 Quick Start

### Download Pre-built Binaries

Download the latest release for your platform from [Releases](https://github.com/your-repo/releases):

| Platform | File | Architecture |
|----------|------|--------------|
| **Windows** | `AIDataBaseMonitor.exe` | x64 |
| **Linux** | `AIDataBaseMonitor` | x64 |
| **macOS** | `AIDataBaseMonitor` | x64/ARM64 |

### Installation

1. **Download** the executable for your platform
2. **Configure** the `.env` file (see [Configuration](#configuration))
3. **Run** the application:

```bash
# Windows
AIDataBaseMonitor.exe

# Linux/macOS
chmod +x AIDataBaseMonitor
./AIDataBaseMonitor
```

4. **Access** the web interface at `http://localhost:8080`

---

## 💻 Supported Platforms

- **Windows**: Windows 10/11 (x64)
- **Linux**: CentOS 7+, Ubuntu 20.04+ (x64)
- **macOS**: macOS 10.15+ Catalina (x64/ARM64)

---

## 🎯 Core Capabilities

### 1. Real-Time Monitoring

- **System Metrics**: CPU usage, memory usage, disk I/O
- **Database Metrics**: Connection count, query response time, throughput
- **Custom Metrics**: Business-specific performance indicators

### 2. AI Fault Prediction

- **Trend Analysis**: Historical data-based trend prediction
- **Anomaly Detection**: Intelligent anomaly detection with >85% accuracy
- **Adaptive Fusion Engine**: Combines DTW, FAISS, and LLM predictions
- **Smart Caching**: 99.9% performance improvement for repeated queries
- **Prediction Horizon**: 1-24 hours advance warning

### 3. Multi-Instance Management

- **Concurrent Monitoring**: Monitor multiple database instances simultaneously
- **Database Support**: MySQL, PostgreSQL, and other mainstream databases
- **Flexible Configuration**: Customizable monitoring intervals and priorities

### 4. Intelligent Alerting

- **Prediction-Based Alerts**: Smart alerts based on AI predictions
- **Configurable Thresholds**: Customizable alert thresholds
- **Multiple Channels**: Support for various notification methods

---

## 🏗️ Technology Stack

### Backend

- **Framework**: FastAPI 0.115.4 (High-performance async framework)
- **Database**: MySQL 5.7+ (Primary) + Redis 6.0+ (Cache)
- **ORM**: SQLAlchemy 2.0.42 (Async ORM) + Alembic 1.13.1 (Migrations)
- **AI/ML**:
  - DTW-Python 1.4.0 (Dynamic Time Warping)
  - FAISS-CPU 1.9.0 (Vector Similarity Search)
  - OpenAI / DeepSeek (Large Language Models)
  - scikit-learn, NumPy, Pandas
  - Adaptive Fusion Engine (Custom)

### Frontend

- **Framework**: Vue.js 3 (Progressive framework)
- **UI Library**: Element Plus (Component library)
- **Visualization**: ECharts (Data visualization)

### Data Sources

- **Prometheus**: Time-series metrics
- **MySQL**: Historical fault data
- **Redis**: Caching and message queue


---

## 📊 System Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│  Database       │    │   Prometheus    │    │  Data Sources   │
│  Instances      │    │                 │    │                 │
└────────┬────────┘    └────────┬────────┘    └────────┬────────┘
         │                      │                      │
         └──────────────────────┼──────────────────────┘
                                │
                   ┌────────────┴────────────┐
                   │   Data Collection       │
                   │   Layer                 │
                   └────────────┬────────────┘
                                │
                   ┌────────────┴────────────┐
                   │   AI Prediction         │
                   │   Analysis Layer        │
                   └────────────┬────────────┘
                                │
                   ┌────────────┴────────────┐
                   │   API Service Layer     │
                   │   (FastAPI)             │
                   └────────────┬────────────┘
                                │
                   ┌────────────┴────────────┐
                   │   Web Interface         │
                   │   (Vue.js)              │
                   └─────────────────────────┘
```

---

## ⚙️ Configuration

### Environment Variables

Edit the `.env` file in the same directory as the executable:

```env
# Web Server Configuration
SERVER_PORT=8080                    # Frontend access port
BACKEND_HOST=127.0.0.1              # Backend API host
BACKEND_PORT=8000                   # Backend API port

# Application Configuration
APP_NAME=AI Database Monitor
APP_VERSION=1.0.0
DEBUG=false                         # Disable debug mode in production
LOG_LEVEL=INFO

# MySQL Configuration
MYSQL_HOST=your_mysql_host
MYSQL_PORT=3306
MYSQL_USER=your_username
MYSQL_PASSWORD=your_password
MYSQL_DATABASE=db_prediction

# Redis Configuration
REDIS_HOST=your_redis_host
REDIS_PORT=6379
REDIS_DB=0

# Prometheus Configuration
PROMETHEUS_URL=http://your_prometheus:9090

# LLM Configuration (Optional)
LLM_PROVIDER=openai                 # Options: openai, deepseek, claude
OPENAI_API_KEY=your_api_key
OPENAI_BASE_URL=https://api.openai.com/v1
```

### System Requirements

**Minimum**:
- CPU: 2 cores
- RAM: 4 GB
- Disk: 500 MB available space
- Network: HTTP/HTTPS access

**Recommended**:
- CPU: 4+ cores
- RAM: 8+ GB
- Disk: 2 GB available space (for logs and cache)
- Network: Gigabit network

---

## 📚 Documentation

- [Quick Start Guide](doc/快速打包参考.md)
- [Configuration Guide](doc/配置说明.md)
- [API Documentation](http://localhost:8080/docs) (After startup)



## 🐛 Troubleshooting

### Common Issues

1. **Startup Failure**: Check port availability and database connection
2. **Data Collection Issues**: Verify database permissions and network connectivity
3. **Prediction Anomalies**: Check data quality and model status

### View Logs

```bash
# Application logs
tail -f logs/app.log

# Search for errors
grep "ERROR" logs/app.log
```

---

## 📄 License

This project is licensed under the AGPL-3.0 License - see the [LICENSE](LICENSE) file for details.

---

## 📧 Contact

- **Issues**: [GitHub Issues](https://github.com/your-repo/issues)
- **Email**: 250305240@qq.com

---

## 🙏 Acknowledgments

Thanks to all contributors who have helped make this project better!

---

<div align="center">

**[⬆ Back to Top](#-ai-database-monitor-prediction-)**

Made with ❤️ by the AI Database Monitor Team

</div>
