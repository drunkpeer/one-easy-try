
CREATE DATABASE PlantManagement
USE PlantManagement-- 数据库


1.植物信息表
CREATE TABLE PlantTable (
  plant_id VARCHAR(50) PRIMARY KEY,-- 植物id
  species_name VARCHAR(100), -- 种名
  disease_name VARCHAR(100) DEFAULT '无', -- 病名 创建的时候默认是无
  equipment_name VARCHAR(100), -- 设备名称
		
  -- 下面是没多大用的
  morphology VARCHAR(255), -- 形态特征
  cultivation_techniques VARCHAR(255), -- 栽培技术要点
  application_value VARCHAR(255),-- 应用价值
  image_id VARCHAR(50),-- 配图编号
  image_location VARCHAR(100), -- 配图拍摄地点
  image_description VARCHAR(255), -- 配图描述
  image_photographer VARCHAR(100), -- 配图拍摄人
  create_people VARCHAR(100), -- 创建人
  create_time DATETIME, -- 创建时间
);


INSERT INTO Plant (plant_id, disease_name, alias, family_name, species_name, morphology, cultivation_techniques, pest_control_measures, application_value, image_id, image_location, image_description, image_photographer, created_by, created_at, updated_at)
VALUES ('1', '蔷薇白粉病', '蔷薇粉状霉菌病', '蔷薇科', '蔷薇属 spp.', '叶片上出现小白斑点', '定期修剪和清除受感染的叶片', '使用硫磺或印楝油等杀菌剂', '观赏用途、香气、切花', '1', '图片路径1.jpg', '图片描述', '约翰·史密斯', '管理员', '2023-01-01 10:00:00', '2023-01-01 10:00:00'),
       ('2', '番茄晚疫病', '晚疫病', '茄科', '番茄 Solanum lycopersicum', '叶子和果实上出现褐色斑点', '适当的间距、良好的通风和使用杀菌剂', '使用铜制品等杀菌剂', '食用水果生产、维生素来源', '2', '图片路径2.jpg', '图片描述', '简·多', '管理员', '2023-02-01 14:30:00', '2023-02-01 14:30:00'),
       ('3', '苹果黑星病', 'Venturia inaequalis', '蔷薇科', '苹果属 spp.', '叶片和果实上出现深色鳞状斑点', '修剪感染的树枝和使用杀菌剂', '使用硫磺或铜制品等杀菌剂', '食用水果生产、制作苹果酒', '3', '图片路径3.jpg', '图片描述', '约翰·多', '管理员', '2023-03-01 09:45:00', '2023-03-01 09:45:00');


SELECT * FROM Plant

2.分类表

-- 植物共有界门纲目科属种七大层次

CREATE TABLE ClassificationTable (
  classification_id INT AUTO_INCREMENT PRIMARY KEY, -- 分类id 主键为int类型，且是自增
  family_name VARCHAR(100), -- 科名
  genus_name VARCHAR(100),-- 属名
  species_name VARCHAR(100), -- 种名
  alias VARCHAR(100),-- 别名（中文俗语名称）
  distribution_id VARCHAR(50),-- 分布区域的id
  growth_environment VARCHAR(255) -- 生长环境
);


分类表需要附带着省市县表，等同于邮政编码，每一个省市县都有一个唯一的邮政编码
CREATE TABLE distributionTable (
  distribution_id VARCHAR(50) PRIMARY KEY,
  province VARCHAR(100),
  city VARCHAR(255),
  town VARCHAR(255)
);


3.治疗表
CREATE TABLE TreatmentTable (
  treat_id INT AUTO_INCREMENT PRIMARY KEY, -- 养护id 主键为int类型，且是自增
  disease_name VARCHAR(100), -- 病名 对应报告书里的的任务名
  prevent_method VARCHAR(255),-- 防治措施 对应报告书里的的任务描述
  plant_id VARCHAR(100),-- 养护对象，对应植物编号
  treat_people VARCHAR(100),-- 对应的养护人 由管理人员选择
  treat_state -- 治疗状态，分为未治疗 和已经治疗
-- 下面是没多大用的
  treat_time DATE, -- 养护时间
  create_time DATETIME, -- 创建时间
);


4.病虫害表
CREATE TABLE DiseaseTable (
  disease_id INT AUTO_INCREMENT PRIMARY KEY,-- 主键为int类型，且是自增
  disease_name VARCHAR(100), -- 病虫害名称 对应植物基本信息的病名
);


 -- 具体如何防治表
 -- 根据措施，让养护人员根据防治措施自己选择哪一个药剂
CREATE TABLE preventTable(
	prevent_id INT AUTO_INCREMENT PRIMARY KEY, -- 防治id 主键为int类型，且是自增
	prevent_method VARCHAR(100), -- 防治方法 与植物信息表里面的防治方法相对应
	drug_name VARCHAR(100), -- 药剂名称
	drug_amount VARCHAR(100), -- 药剂用量
	prevention_detail VARCHAR(255), -- 具体实施药剂措施 描述
	action_period VARCHAR(100) -- 作用期限
)



5.监测管理表
监测人员进入页面点击监测之后，
需要填写 病名（系统通过病表给出，自己选择）
还需要填写监测指标ph和温度（自己选择） 
 
1.需要选择在病虫害表中选择病名，改写植物基本信息表
2.需要生成一条监测记录
CREATE TABLE MonitorTable (
  monitor_id INT AUTO_INCREMENT PRIMARY KEY,-- 主键为int类型，且是自增
  plant_id VARCHAR(100),-- 监测对象，对应植物id
  monitor_people VARCHAR(100), -- 监测人  
  ph INT , -- 默认1到14,不包含小数
  temperature INT ,-- 默认是整数
  
  -- 下面没用
  monitor_time DATETIME, -- 检测时间
  monitor_location VARCHAR(100), -- 检测地点
);


养护人员看不见养护表，进入页面只能看到植物信息表，看到自己该养护的植物，并选择药剂
检测人员看不见检测表，进入页面也是

CREATE TABLE equipmenTable(
equipment_id VARCHAR(20) PRIMARY KEY ,-- 对应设备表
equipment_name VARCHAR(20) -- 设备名称
)



