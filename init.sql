CREATE DATABASE `db_prediction` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

use `db_prediction`;

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for alembic_version
-- ----------------------------
DROP TABLE IF EXISTS `alembic_version`;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of alembic_version
-- ----------------------------
INSERT INTO `alembic_version` VALUES ('1.0.0');

-- ----------------------------
-- Table structure for data_quality_summary
-- ----------------------------
DROP TABLE IF EXISTS `data_quality_summary`;
CREATE TABLE `data_quality_summary` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `instance_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '实例ID',
  `summary_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '汇总时间',
  `avg_completeness` decimal(5,4) DEFAULT NULL COMMENT '平均完整度(0.0000-1.0000)',
  `min_completeness` decimal(5,4) DEFAULT NULL COMMENT '最小完整度(0.0000-1.0000)',
  `max_completeness` decimal(5,4) DEFAULT NULL COMMENT '最大完整度(0.0000-1.0000)',
  `quality_distribution` json DEFAULT NULL COMMENT '质量分布(JSON格式: {excellent: count, good: count, fair: count, poor: count})',
  `total_checks` int(11) NOT NULL DEFAULT '0' COMMENT '总检查次数',
  `alert_count` int(11) NOT NULL DEFAULT '0' COMMENT '告警次数',
  `metrics_checked` json DEFAULT NULL COMMENT '检查的指标列表(JSON格式: [metric_name1, metric_name2, ...])',
  `quality_issues` json DEFAULT NULL COMMENT '质量问题详情(JSON格式: [{metric: name, issue: description, severity: level}, ...])',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_instance_time` (`instance_id`,`summary_time`),
  KEY `idx_summary_time` (`summary_time`),
  KEY `idx_instance_id` (`instance_id`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_alert_count` (`alert_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='数据质量汇总表';

-- ----------------------------
-- Records of data_quality_summary
-- ----------------------------

-- ----------------------------
-- Table structure for dtw_patterns
-- ----------------------------
DROP TABLE IF EXISTS `dtw_patterns`;
CREATE TABLE `dtw_patterns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pattern_name` varchar(100) NOT NULL COMMENT '模式名称',
  `instance_id` varchar(100) NOT NULL COMMENT '实例ID',
  `metric_name` varchar(100) NOT NULL COMMENT '指标名称',
  `pattern_data` text NOT NULL COMMENT '模式数据(JSON格式)',
  `pattern_length` int(11) NOT NULL COMMENT '模式长度',
  `pattern_hash` varchar(64) NOT NULL COMMENT '模式哈希值',
  `similarity_threshold` decimal(5,4) DEFAULT '0.8000' COMMENT '相似度阈值',
  `usage_count` int(11) DEFAULT '0' COMMENT '使用次数',
  `last_used_at` timestamp NULL DEFAULT NULL COMMENT '最后使用时间',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_pattern_hash` (`pattern_hash`),
  KEY `idx_pattern_name` (`pattern_name`),
  KEY `idx_usage_count` (`usage_count`),
  KEY `idx_dtw_instance_metric` (`instance_id`,`metric_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='DTW模式库表';

-- ----------------------------
-- Records of dtw_patterns
-- ----------------------------

-- ----------------------------
-- Table structure for fault_events
-- ----------------------------
DROP TABLE IF EXISTS `fault_events`;
CREATE TABLE `fault_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instance_id` varchar(100) NOT NULL COMMENT '实例ID',
  `event_type` varchar(50) NOT NULL COMMENT '事件类型',
  `severity` varchar(20) NOT NULL COMMENT '严重程度',
  `description` text COMMENT '事件描述',
  `occurred_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '发生时间',
  `resolved_at` timestamp NULL DEFAULT NULL COMMENT '解决时间',
  `is_resolved` tinyint(1) DEFAULT '0' COMMENT '是否已解决',
  `resolved_by` varchar(100) DEFAULT NULL COMMENT '处理人',
  `resolution_notes` text COMMENT '解决方案说明',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_instance_event` (`instance_id`,`event_type`),
  KEY `idx_occurred_at` (`occurred_at`),
  KEY `idx_severity` (`severity`),
  KEY `idx_is_resolved` (`is_resolved`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='故障事件表';

-- ----------------------------
-- Records of fault_events
-- ----------------------------

-- ----------------------------
-- Table structure for instance_configs
-- ----------------------------
DROP TABLE IF EXISTS `instance_configs`;
CREATE TABLE `instance_configs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instance_id` varchar(100) NOT NULL COMMENT '实例ID',
  `instance_name` varchar(200) NOT NULL COMMENT '实例名称',
  `db_type` varchar(20) NOT NULL COMMENT '数据库类型',
  `host` varchar(255) NOT NULL COMMENT '主机地址',
  `port` int(11) NOT NULL COMMENT '端口号',
  `pwd` varchar(50) DEFAULT NULL COMMENT '数据库密码',
  `description` text COMMENT '实例描述',
  `tags` json DEFAULT NULL COMMENT '实例标签',
  `status` varchar(20) DEFAULT 'active' COMMENT '实例运行状态:active启用|inactive停用',
  `running_status` varchar(20) DEFAULT 'inactive' COMMENT '采集任务运行状态: active/inactive/error/starting/stopping',
  `collection_source` tinyint(4) DEFAULT '2' COMMENT '监控数据来源：1-从数据库采集数据，2-从prometheus采集数据',
  `prometheus_config` json DEFAULT NULL COMMENT 'Prometheus配置',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `last_active_at` timestamp NULL DEFAULT NULL COMMENT '最后活跃时间',
  `collection_config` json DEFAULT NULL COMMENT '采集配置参数',
  `collection_interval` int(11) DEFAULT NULL COMMENT '采集间隔(秒)',
  `latest_prediction_probability` decimal(5,4) DEFAULT NULL COMMENT '最新异常概率(0.0000-1.0000)',
  `latest_prediction_confidence` decimal(5,4) DEFAULT NULL COMMENT '最新预测置信度(0.0000-1.0000)',
  `latest_prediction_alert_level` varchar(20) DEFAULT NULL COMMENT '最新告警级别(LOW/MEDIUM/HIGH/CRITICAL)',
  `latest_prediction_metric` varchar(50) DEFAULT NULL COMMENT '最新预测指标名称',
  `latest_prediction_time` timestamp NULL DEFAULT NULL COMMENT '最新预测时间',
  `config_prediction_metric_name` varchar(200) DEFAULT NULL COMMENT '最新预测配置名称（对应prediction_configs表metric_name）',
  `predicted_value_30min` decimal(10,2) DEFAULT NULL COMMENT '30分钟后预测值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `instance_id` (`instance_id`),
  KEY `idx_db_type` (`db_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='实例配置表';

-- ----------------------------
-- Records of instance_configs
-- ----------------------------

-- ----------------------------
-- Table structure for instance_tasks
-- ----------------------------
DROP TABLE IF EXISTS `instance_tasks`;
CREATE TABLE `instance_tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` varchar(100) NOT NULL COMMENT '任务唯一标识',
  `instance_id` varchar(100) NOT NULL COMMENT '关联实例ID',
  `task_type` varchar(50) NOT NULL COMMENT '任务类型: data_collection/health_check',
  `status` varchar(20) NOT NULL COMMENT '任务状态: pending/running/completed/failed',
  `start_time` timestamp NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` timestamp NULL DEFAULT NULL COMMENT '结束时间',
  `result` json DEFAULT NULL COMMENT '执行结果',
  `error_message` text COMMENT '错误信息',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_id` (`task_id`),
  KEY `idx_instance_id` (`instance_id`),
  KEY `idx_instance_status` (`instance_id`,`status`),
  KEY `idx_instance_task_type` (`instance_id`,`task_type`),
  KEY `idx_task_created_at` (`created_at`),
  KEY `idx_task_id` (`task_id`),
  KEY `idx_task_start_time` (`start_time`),
  KEY `idx_task_status` (`status`),
  KEY `idx_task_type` (`task_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='实例任务表';

-- ----------------------------
-- Records of instance_tasks
-- ----------------------------

-- ----------------------------
-- Table structure for llm_analysis_history
-- ----------------------------
DROP TABLE IF EXISTS `llm_analysis_history`;
CREATE TABLE `llm_analysis_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `analysis_type` enum('anomaly_detection','fault_prediction','pattern_analysis','root_cause_analysis','sample_quality') NOT NULL COMMENT '分析类型',
  `instance_id` varchar(100) NOT NULL COMMENT '数据库实例ID',
  `metric_name` varchar(100) DEFAULT NULL COMMENT '指标名称',
  `request_data` text COMMENT '请求数据(JSON)',
  `confidence` float DEFAULT NULL COMMENT '置信度',
  `result_summary` text COMMENT '结果摘要',
  `result_detail` text COMMENT '详细结果(JSON)',
  `llm_provider` varchar(50) DEFAULT NULL COMMENT 'LLM提供商',
  `llm_model` varchar(100) DEFAULT NULL COMMENT 'LLM模型',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `response_time` float DEFAULT NULL COMMENT '响应时间(秒)',
  `status` varchar(20) DEFAULT 'success' COMMENT '状态: success/failed',
  `error_message` text COMMENT '错误信息',
  PRIMARY KEY (`id`),
  KEY `idx_instance_id` (`instance_id`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_analysis_type` (`analysis_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='LLM分析历史记录表';

-- ----------------------------
-- Records of llm_analysis_history
-- ----------------------------

-- ----------------------------
-- Table structure for llm_samples
-- ----------------------------
DROP TABLE IF EXISTS `llm_samples`;
CREATE TABLE `llm_samples` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sample_id` varchar(100) NOT NULL COMMENT '样本ID',
  `instance_id` varchar(100) NOT NULL COMMENT '实例ID',
  `sample_data` text NOT NULL COMMENT '样本数据(JSON格式)',
  `llm_analysis` text COMMENT 'LLM分析结果',
  `quality_score` decimal(5,4) DEFAULT NULL COMMENT '质量评分',
  `feedback_score` decimal(5,4) DEFAULT NULL COMMENT '反馈评分',
  `is_selected` tinyint(1) DEFAULT '0' COMMENT '是否被选中',
  `selection_reason` text COMMENT '选择原因',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sample_id` (`sample_id`),
  KEY `idx_sample_id` (`sample_id`),
  KEY `idx_quality_score` (`quality_score`),
  KEY `idx_is_selected` (`is_selected`),
  KEY `idx_llm_instance_id` (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='LLM样本表';

-- ----------------------------
-- Records of llm_samples
-- ----------------------------

-- ----------------------------
-- Table structure for metric_configs
-- ----------------------------
DROP TABLE IF EXISTS `metric_configs`;
CREATE TABLE `metric_configs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `db_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '数据库类型: mysql/redis',
  `metric_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '指标名称',
  `prometheus_metric_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'prometheus指标名称对应的数据库监控指标名称',
  `alert_correlator_metric_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'AlertCorrelator使用的指标名称(如cpu_usage, memory_usage)',
  `metric_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '指标描述',
  `is_enabled` tinyint(1) DEFAULT '1' COMMENT '是否启用',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `warning_threshold` decimal(10,2) DEFAULT NULL COMMENT '警告阈值',
  `critical_threshold` decimal(10,2) DEFAULT NULL COMMENT '严重阈值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_db_type_metric` (`db_type`,`metric_name`),
  UNIQUE KEY `idx_db_metric_unique` (`db_type`,`metric_name`),
  KEY `idx_db_type` (`db_type`),
  KEY `idx_enabled` (`is_enabled`),
  KEY `idx_metric_created_at` (`created_at`),
  KEY `idx_alert_correlator_metric` (`alert_correlator_metric_name`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='监控指标配置表';

-- ----------------------------
-- Records of metric_configs
-- ----------------------------
INSERT INTO `metric_configs` VALUES ('1', 'mysql', 'sum_slowqueries', 'qce_cdb_slowqueries_sum', 'slow_queries', '慢查询数', '1', '2025-08-06 15:57:57', '2025-11-06 10:24:37', '200.00', '400.00');
INSERT INTO `metric_configs` VALUES ('2', 'mysql', 'max_cpu', 'qce_cdb_cpuuserate_max', 'cpu_usage', 'CPU使用率最大值(%)', '1', '2025-08-06 15:57:57', '2025-11-04 16:29:01', '70.00', '90.00');
INSERT INTO `metric_configs` VALUES ('3', 'mysql', 'max_qps', 'qce_cdb_qps_max', 'qps', 'QPS最大值(次/秒)', '1', '2025-08-06 15:57:57', '2025-11-04 16:29:02', '10000.00', '50000.00');
INSERT INTO `metric_configs` VALUES ('4', 'mysql', 'max_threadsrunning', 'qce_cdb_threadsrunning_max', 'threads_running', '运行线程数最大值', '1', '2025-08-06 15:57:57', '2025-11-04 16:29:03', '50.00', '100.00');
INSERT INTO `metric_configs` VALUES ('5', 'mysql', 'max_tps', 'qce_cdb_tps_max', 'tps', 'TPS最大值(次/秒)', '1', '2025-08-06 15:57:57', '2025-11-20 13:40:15', '5000.00', '10000.00');
INSERT INTO `metric_configs` VALUES ('6', 'mysql', 'max_volumerate', 'qce_cdb_volumerate_max', 'volume_rate', '磁盘使用率最大值(%)', '1', '2025-08-06 15:57:57', '2025-11-20 13:40:28', '75.00', '95.00');
INSERT INTO `metric_configs` VALUES ('7', 'redis', 'max_cpu', 'qce_redis_mem_cpumaxutil_max', 'cpu_usage', 'CPU使用率最大值(%)', '1', '2025-08-06 15:57:57', '2025-11-20 13:39:28', '70.00', '90.00');
INSERT INTO `metric_configs` VALUES ('8', 'redis', 'max_keys', 'qce_redis_mem_keys_max', null, 'Key数量最大值', '0', '2025-08-06 15:57:57', '2025-11-20 13:39:29', '1000000.00', '10000000.00');
INSERT INTO `metric_configs` VALUES ('9', 'redis', 'max_memory', 'qce_redis_mem_memutil_max', 'memory_usage', '内存使用率最大值(%)', '1', '2025-08-06 15:57:57', '2025-11-20 13:39:30', '80.00', '95.00');
INSERT INTO `metric_configs` VALUES ('10', 'redis', 'max_qps', 'qce_redis_mem_commands_avg', null, 'QPS平均值(次/秒)', '1', '2025-08-06 15:57:57', '2025-11-20 13:41:01', '50000.00', '100000.00');
INSERT INTO `metric_configs` VALUES ('11', 'mysql', 'max_memory', 'qce_cdb_memoryuserate_max', 'memory_usage', '内存使用率最大值(%)', '1', '2025-08-06 17:15:45', '2025-11-20 13:39:33', '80.00', '95.00');

-- ----------------------------
-- Table structure for monitoring_metrics
-- ----------------------------
DROP TABLE IF EXISTS `monitoring_metrics`;
CREATE TABLE `monitoring_metrics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instance_id` varchar(100) NOT NULL COMMENT '实例ID',
  `metric_name` varchar(100) NOT NULL COMMENT '指标名称',
  `metric_value` decimal(15,6) NOT NULL COMMENT '指标值',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '指标时间戳',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_instance_metric` (`instance_id`,`metric_name`),
  KEY `idx_timestamp` (`timestamp`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='监控指标数据表';

-- ----------------------------
-- Records of monitoring_metrics
-- ----------------------------

-- ----------------------------
-- Table structure for predictions
-- ----------------------------
DROP TABLE IF EXISTS `predictions`;
CREATE TABLE `predictions` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `instance_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '实例ID',
  `metric_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '指标名称(cpu_usage/memory_usage/connections等)',
  `anomaly_probability` decimal(5,4) NOT NULL COMMENT '异常概率(0.0000-1.0000)',
  `confidence` decimal(5,4) NOT NULL COMMENT '置信度(0.0000-1.0000)',
  `alert_level` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '告警级别(LOW/MEDIUM/HIGH/CRITICAL)',
  `predicted_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '预测时间',
  `prediction_details` text COLLATE utf8mb4_unicode_ci COMMENT '预测详情(JSON格式,包含method_results/trend_analysis/features/metadata)',
  `prediction_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '预测类型(anomaly/trend/capacity等)',
  `prediction_window_minutes` int(11) DEFAULT NULL COMMENT '预测窗口(分钟)',
  `algorithm_used` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '使用的算法(dtw/faiss/llm/fusion)',
  `algorithm_version` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '算法版本',
  `features_used` text COLLATE utf8mb4_unicode_ci COMMENT '使用的特征(JSON格式)',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_instance_id` (`instance_id`),
  KEY `idx_instance_metric` (`instance_id`,`metric_name`),
  KEY `idx_predicted_at` (`predicted_at`),
  KEY `idx_alert_level` (`alert_level`),
  KEY `idx_anomaly_probability` (`anomaly_probability`),
  KEY `idx_algorithm` (`algorithm_used`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_instance_metric_time` (`instance_id`,`metric_name`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='预测结果表';

-- ----------------------------
-- Records of predictions
-- ----------------------------

-- ----------------------------
-- Table structure for prediction_configs
-- ----------------------------
DROP TABLE IF EXISTS `prediction_configs`;
CREATE TABLE `prediction_configs` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `metric_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '预测指标英文名称',
  `metric_cn_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '预测指标中文名称',
  `config_description` text COLLATE utf8mb4_unicode_ci COMMENT '配置描述',
  `prediction_type` enum('single_metric','multi_metric','correlation') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'single_metric' COMMENT '预测类型',
  `target_metric` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '目标预测指标（单指标预测时使用）',
  `feature_metrics` json DEFAULT NULL COMMENT '特征指标列表（多指标预测时使用）',
  `enabled_algorithms` json DEFAULT NULL COMMENT '启用的算法列表',
  `algorithm_weights` json DEFAULT NULL COMMENT '算法权重配置（可选，覆盖全局权重）',
  `fusion_config` json DEFAULT NULL COMMENT '融合配置（用于multi_metric类型）',
  `correlation_config` json DEFAULT NULL COMMENT '关联配置（用于correlation类型）',
  `db_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '数据库类型: mysql/redis',
  `is_enabled` tinyint(1) DEFAULT '1' COMMENT '是否启用',
  `priority` int(11) DEFAULT '100' COMMENT '优先级（数值越小优先级越高）',
  `instance_filter` json DEFAULT NULL COMMENT '实例过滤规则（可选）',
  `prediction_interval` int(11) DEFAULT NULL COMMENT '预测间隔（秒，可选，覆盖全局配置）',
  `data_window_minutes` int(11) DEFAULT '30' COMMENT '数据窗口（分钟）',
  `anomaly_threshold` decimal(5,4) DEFAULT '0.5000' COMMENT '异常概率阈值',
  `confidence_threshold` decimal(5,4) DEFAULT '0.6000' COMMENT '置信度阈值',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_db_type` (`db_type`),
  KEY `idx_prediction_type` (`prediction_type`),
  KEY `idx_is_enabled` (`is_enabled`),
  KEY `idx_priority` (`priority`),
  KEY `idx_target_metric` (`target_metric`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='预测配置表';

-- ----------------------------
-- Records of prediction_configs
-- ----------------------------
INSERT INTO `prediction_configs` VALUES ('1', 'max_cpu', 'CPU使用率', 'CPU使用率进行单指标预测', 'single_metric', 'max_cpu', null, '[\"dtw\", \"faiss\", \"llm\"]', null, null, null, 'mysql', '1', '10', null);
INSERT INTO `prediction_configs` VALUES ('2', 'max_memory', '内存使用率', '内存使用率进行单指标预测', 'single_metric', 'max_memory', null, '[\"dtw\", \"faiss\", \"llm\"]', null, null, null, 'mysql', '0', '20', null);
INSERT INTO `prediction_configs` VALUES ('3', 'max_threadsrunning', '并发连接数', '并发连接数进行单指标预测', 'single_metric', 'max_threadsrunning', null, '[\"dtw\", \"faiss\", \"llm\"]', null, null, null, 'mysql', '1', '40', null);
INSERT INTO `prediction_configs` VALUES ('4', 'max_qps', 'QPS', '每秒查询数进行单指标预测', 'single_metric', 'max_qps', null, '[\"dtw\", \"faiss\", \"llm\"]', null, null, null, 'mysql', '1', '30', null);
INSERT INTO `prediction_configs` VALUES ('5', 'max_tps', 'TPS', '每秒事务数进行单指标预测', 'single_metric', 'max_tps', null, '[\"dtw\", \"faiss\", \"llm\"]', null, null, null, 'mysql', '0', '50', null);
INSERT INTO `prediction_configs` VALUES ('6', 'max_cpu', 'CPU使用率', '对Redis实例的CPU使用率进行单指标预测', 'single_metric', 'max_cpu', null, '[\"dtw\", \"faiss\", \"llm\"]', null, null, null, 'redis', '1', '100', null);
INSERT INTO `prediction_configs` VALUES ('7', 'max_memory', '内存使用率', '对Redis实例的内存使用率进行单指标预测', 'single_metric', 'max_memory', null, '[\"dtw\", \"faiss\", \"llm\"]', null, null, null, 'redis', '1', '20', null);
INSERT INTO `prediction_configs` VALUES ('8', 'system_helath', '系统健康', '基于CPU、内存、磁盘使用率、QPS、并发数的综合预测，用于预测系统故障风险', 'multi_metric', null, '{\"description\": \"基于CPU、内存、磁盘使用率、QPS、并发数的综合预测\", \"input_metrics\": [\"max_cpu\", \"max_memory\", \"max_volumerate\", \"max_qps\", \"max_threadsrunning\"]}', '[\"dtw\", \"faiss\", \"llm\"]', null, '{\"method\": \"weighted_average\", \"description\": \"自适应权重加权平均融合\", \"custom_weights\": {}, \"weight_strategy\": \"auto\"}', null, 'mysql', '1', '100', null);
INSERT INTO `prediction_configs` VALUES ('9', 'cpu_from_metric', '关键指标预测CPU使用率', '基于QPS/慢日志/并发数预测CPU使用率，用于关联分析', 'correlation', null, '{\"description\": \"基于关键指标预测CPU使用率\", \"input_metrics\": [\"max_qps\", \"sum_slowqueries\", \"max_threadsrunning\"], \"target_metric\": \"max_cpu\", \"correlation_config\": {\"lag_minutes\": 5, \"min_data_points\": 10, \"prediction_method\": \"regression\", \"correlation_method\": \"pearson\", \"correlation_threshold\": 0.7}}', '[\"dtw\", \"faiss\", \"llm\"]', null, null, '{\"description\": \"前馈-反馈控制关联预测\", \"lag_minutes\": 5, \"feedback_weight\": 0.4, \"min_data_points\": 10, \"prediction_method\": \"regression\", \"correlation_method\": \"pearson\", \"feedforward_weight\": 0.6, \"correlation_threshold\": 0.7}', 'mysql', '1', '80', null);

-- ----------------------------
-- Table structure for system_configs
-- ----------------------------
DROP TABLE IF EXISTS `system_configs`;
CREATE TABLE `system_configs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `config_key` varchar(100) NOT NULL COMMENT '配置键',
  `config_value` text NOT NULL COMMENT '配置值',
  `config_type` varchar(20) NOT NULL COMMENT '配置类型',
  `description` text COMMENT '配置描述',
  `is_encrypted` tinyint(1) DEFAULT NULL COMMENT '是否加密',
  `is_active` tinyint(1) DEFAULT '1' COMMENT '是否启用',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `config_key` (`config_key`),
  KEY `idx_config_type` (`config_type`),
  KEY `idx_config_key` (`config_key`),
  KEY `idx_config_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COMMENT='系统配置表';

-- ----------------------------
-- Records of system_configs
-- ----------------------------
INSERT INTO `system_configs` VALUES ('1', 'PREDICTION_INTERVAL', '120', 'int', '预测任务的执行间隔时间(秒)', '0', '1', null, '2025-10-17 12:05:20');
INSERT INTO `system_configs` VALUES ('2', 'PREDICTION_DATA_WINDOW', '30', 'int', '预测数据窗口(分钟)：基于过去30分钟的数据,判断当前/近期的异常概率。配置优先级 (从高到低): prediction_configs 表的 data_window_minutes 字段>system_configs 表的 PREDICTION_DATA_WINDOW 参数>.env 文件的 PREDICTION_DATA_WINDOW 环境变量>代码默认值 (30分钟)', '0', '1', null, null);
INSERT INTO `system_configs` VALUES ('3', 'PREDICTION_MAX_CONCURRENT', '10', 'int', '最大并发预测数', '0', '1', null, null);
INSERT INTO `system_configs` VALUES ('4', 'BLACKLIST_MAX_FAILURES', '3', 'int', '黑名单最大失败次数', '0', '1', null, null);
INSERT INTO `system_configs` VALUES ('5', 'BLACKLIST_DURATION', '1800', 'int', '黑名单持续时间(秒)', '0', '1', null, null);
INSERT INTO `system_configs` VALUES ('6', 'ENABLE_PREDICTION_DEDUP', 'true', 'bool', '启用预测去重', '0', '1', null, null);
INSERT INTO `system_configs` VALUES ('7', 'PREDICTION_DEDUP_WINDOW', '60', 'int', '预测去重窗口(秒)', '0', '1', null, null);
INSERT INTO `system_configs` VALUES ('8', 'ENABLE_PERFORMANCE_MONITOR', 'true', 'bool', '启用性能监控', '0', '1', null, null);
INSERT INTO `system_configs` VALUES ('9', 'DTW_BASELINE_DAYS_MIN', '3', 'int', 'DTW最小基线天数', null, '1', '2025-10-23 11:08:40', '2025-10-23 11:08:40');
INSERT INTO `system_configs` VALUES ('10', 'DTW_BASELINE_DAYS_MAX', '15', 'int', 'DTW最大基线天数', null, '1', '2025-10-23 11:08:40', '2025-10-23 11:08:40');
INSERT INTO `system_configs` VALUES ('11', 'DTW_MIN_BASELINE_PATTERNS', '3', 'int', 'DTW最少基线模式数', null, '1', '2025-10-23 11:08:40', '2025-10-23 11:08:40');
INSERT INTO `system_configs` VALUES ('12', 'DTW_ANOMALY_THRESHOLD', '0.3', 'float', 'DTW异常阈值', null, '1', '2025-10-23 11:08:40', '2025-10-23 11:08:40');
INSERT INTO `system_configs` VALUES ('13', 'VECTOR_INDEX_BUILD_ENABLED', 'true', 'bool', '启用向量索引构建', null, '1', '2025-10-23 11:08:40', '2025-10-23 11:08:40');
INSERT INTO `system_configs` VALUES ('14', 'VECTOR_INDEX_BUILD_INTERVAL', '3600', 'int', '向量索引构建间隔(秒)', null, '1', '2025-10-23 11:08:40', '2025-10-23 11:08:40');
INSERT INTO `system_configs` VALUES ('15', 'VECTOR_INDEX_LOOKBACK_DAYS', '15', 'int', 'FAISS向量索引回溯天数（与FAISS实际使用的15天保持一致）', null, '1', '2025-10-23 11:08:40', '2025-10-30 18:03:15');
INSERT INTO `system_configs` VALUES ('16', 'VECTOR_INDEX_MIN_SAMPLES', '10', 'int', '向量索引最小样本数', null, '1', '2025-10-23 11:08:40', '2025-10-23 11:08:40');
INSERT INTO `system_configs` VALUES ('17', 'fusion_weights', '{\"dtw\": 0.15, \"vector\": 0.25, \"llm\": 0.6}', 'json', '融合算法权重配置（已优化：降低DTW权重，提高LLM权重）', null, '1', '2025-10-23 15:32:09', '2025-10-23 16:23:12');
INSERT INTO `system_configs` VALUES ('20', 'USE_ENHANCED_TREND_ANALYZER', 'true', 'bool', '是否使用增强版趋势分析器(支持周期性检测、异常值过滤、自适应预测)。配置优先级(由高到低): system_configs表 > .env文件 > 代码默认值', '0', '1', null, '2025-11-06 19:40:40');
INSERT INTO `system_configs` VALUES ('21', 'TREND_ANALYZER_PERIODICITY_THRESHOLD', '0.3', 'float', '周期性检测阈值(0.3表示周期性功率占比>30%才认为有周期性)。仅在启用增强版趋势分析器时生效', '0', '1', null, null);
INSERT INTO `system_configs` VALUES ('22', 'TREND_ANALYZER_OUTLIER_IQR_MULTIPLIER', '1.5', 'float', '异常值IQR倍数(1.5是标准值,用于过滤异常数据点)。仅在启用增强版趋势分析器时生效', '0', '1', null, null);
INSERT INTO `system_configs` VALUES ('23', 'HISTORICAL_PATTERN_DAYS', '15', 'int', '历史同期预测数据天数(从Prometheus读取)', null, '1', null, null);
INSERT INTO `system_configs` VALUES ('24', 'HISTORICAL_PATTERN_MIN_SAMPLES', '50', 'int', '历史同期预测最小样本数(样本不足时使用其他预测方法)', null, '1', null, null);
INSERT INTO `system_configs` VALUES ('25', 'HISTORICAL_PATTERN_DECAY_DAYS', '7.0', 'float', '历史同期预测时间衰减因子(天,用于计算历史数据权重)', null, '1', null, null);
INSERT INTO `system_configs` VALUES ('26', 'HISTORICAL_PATTERN_MATCH_WEEKDAY', 'true', 'bool', '历史同期预测是否匹配星期(True=区分工作日/周末)', null, '1', null, null);
INSERT INTO `system_configs` VALUES ('27', 'DTW_DATA_SOURCE', 'prometheus', 'string', 'DTW数据源配置：prometheus=从Prometheus直接查询（推荐），database=从monitoring_metrics表查询（已废弃）', '0', '1', '2025-10-29 22:22:22', '2025-10-30 18:03:03');
INSERT INTO `system_configs` VALUES ('28', 'prometheus_instance_label', 'instance_id', 'string', 'Prometheus PromQL查询中的实例过滤标签名称。支持的值: instance_id(默认,适用于腾讯云CDB), instance(适用于标准Prometheus), server_id(适用于自定义监控)等。修改后需重启应用生效。', '0', '1', '2025-10-30 16:56:04', '2025-10-30 16:56:04');
INSERT INTO `system_configs` VALUES ('29', 'FAISS_DATA_SOURCE', 'prometheus', 'string', 'FAISS向量索引数据源：prometheus=从Prometheus直接查询（当前实现），database=从monitoring_metrics表查询（未实现）', null, '1', '2025-10-30 18:03:10', '2025-10-30 18:03:10');

-- ----------------------------
-- Table structure for system_logs
-- ----------------------------
DROP TABLE IF EXISTS `system_logs`;
CREATE TABLE `system_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `log_level` varchar(20) NOT NULL COMMENT '日志级别',
  `module_name` varchar(100) NOT NULL COMMENT '模块名称',
  `message` text NOT NULL COMMENT '日志消息',
  `exception_info` text COMMENT '异常信息',
  `request_id` varchar(100) DEFAULT NULL COMMENT '请求ID',
  `user_id` varchar(100) DEFAULT NULL COMMENT '用户ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_log_level` (`log_level`),
  KEY `idx_module_name` (`module_name`),
  KEY `idx_request_id` (`request_id`),
  KEY `idx_log_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统日志表';

-- ----------------------------
-- Records of system_logs
-- ----------------------------

-- ----------------------------
-- Table structure for vector_indexes
-- ----------------------------
DROP TABLE IF EXISTS `vector_indexes`;
CREATE TABLE `vector_indexes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `index_name` varchar(100) NOT NULL COMMENT '索引名称',
  `instance_id` varchar(100) NOT NULL COMMENT '实例ID',
  `feature_vector` text NOT NULL COMMENT '特征向量(JSON格式)',
  `vector_dimension` int(11) NOT NULL COMMENT '向量维度',
  `vector_metadata` text COMMENT '元数据(JSON格式)',
  `vector_hash` varchar(64) NOT NULL COMMENT '向量哈希值',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_vector_hash` (`vector_hash`),
  KEY `idx_index_name` (`index_name`),
  KEY `idx_vector_dimension` (`vector_dimension`),
  KEY `idx_vector_instance_id` (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='向量索引表';

-- ----------------------------
-- Records of vector_indexes
-- ----------------------------

SET FOREIGN_KEY_CHECKS=1;
