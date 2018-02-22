USE [ModelDB]

-- Script was generated by Devart Entity Developer, Version 6.0.172.0
-- Script date 10/24/2017 9:01:37 AM
-- Target Server: SQL Server
-- Server Version: 2014

-- 
-- Dropping a table dbo.MapTypesCapabilitiesControls 
-- 
DROP TABLE IF EXISTS dbo.MapTypesCapabilitiesControls
GO

-- 
-- Dropping a table dbo.BaselineSecurityMappings 
-- 
DROP TABLE IF EXISTS  dbo.BaselineSecurityMappings
GO

-- 
-- Dropping a table dbo.Specs 
-- 
DROP TABLE IF EXISTS  dbo.Specs
GO

-- 
-- Dropping a table dbo.Relateds 
-- 
DROP TABLE IF EXISTS  dbo.Relateds
GO

-- 
-- Dropping a table dbo.Controls 
-- 
DROP TABLE IF EXISTS  dbo.Controls
GO

-- 
-- Dropping a table dbo.TICMappings 
-- 
DROP TABLE IF EXISTS  dbo.TICMappings
GO

-- 
-- Dropping a table dbo.Baselines 
-- 
DROP TABLE IF EXISTS  dbo.Baselines
GO

-- 
-- Dropping a table dbo.Capabilities 
-- 
DROP TABLE IF EXISTS  dbo.Capabilities
GO

-- 
-- Dropping a table dbo.Families 
-- 
DROP TABLE IF EXISTS  dbo.Families
GO

-- 
-- Dropping a table dbo.Priorities 
-- 
DROP TABLE IF EXISTS  dbo.Priorities
GO

-- 
-- Creating a table dbo.Families 
-- 
CREATE TABLE dbo.Families (
   Id BIGINT NOT NULL IDENTITY,
   Name VARCHAR(8000) NOT NULL,
   Description VARCHAR(8000),
   CONSTRAINT PK_Families PRIMARY KEY (Id)
)
GO

-- 
-- Creating a table dbo.Priorities 
-- 
CREATE TABLE dbo.Priorities (
   Id BIGINT NOT NULL IDENTITY,
   Name VARCHAR(8000) NOT NULL,
   Description VARCHAR(8000),
   CONSTRAINT PK_Priorities PRIMARY KEY (Id)
)
GO

-- 
-- Creating a table dbo.Baselines 
-- 
CREATE TABLE dbo.Baselines (
   Id BIGINT NOT NULL IDENTITY,
   ImpactLow BIT NOT NULL,
   ImpactModerate BIT NOT NULL,
   ImpactHigh BIT NOT NULL,
   Description VARCHAR(8000) NOT NULL,
   CONSTRAINT PK_Baselines PRIMARY KEY (Id)
)
GO

-- 
-- Creating a table dbo.Capabilities 
-- 
CREATE TABLE dbo.Capabilities (
   Id BIGINT NOT NULL IDENTITY,
   Domain VARCHAR(8000) NOT NULL,
   Container VARCHAR(8000) NOT NULL,
   Capability VARCHAR(8000) NOT NULL,
   Capability2 VARCHAR(8000),
   UniqueId VARCHAR(8000) NOT NULL,
   Description VARCHAR(8000) NOT NULL,
   CSADescription VARCHAR(8000),
   Notes VARCHAR(8000),
   Scopes VARCHAR(8000) NOT NULL,
   C BIGINT NOT NULL,
   I BIGINT NOT NULL,
   A BIGINT NOT NULL,
   ResponsibilityVector VARCHAR(8000) NOT NULL,
   OtherActors VARCHAR(8000) NOT NULL,
   CONSTRAINT PK_Capabilities PRIMARY KEY (Id)
)
GO

-- 
-- Commenting a table dbo.Capabilities 
-- 
EXECUTE sp_addextendedproperty 'MS_Description', 'Teh primary key of the  capability', 'schema', 'dbo', 'table', 'Capabilities'
GO

-- 
-- Creating a table dbo.TICMappings 
-- 
CREATE TABLE dbo.TICMappings (
   Id BIGINT NOT NULL IDENTITY,
   CapabilityId BIGINT NOT NULL,
   TICName VARCHAR(8000) NOT NULL,
   CONSTRAINT PK_TICMappings PRIMARY KEY (Id),
   CONSTRAINT FK_TICMappings_Capabilities1 FOREIGN KEY (CapabilityId) REFERENCES dbo.Capabilities (Id)
)
GO

-- 
-- Creating a table dbo.Controls 
-- 
CREATE TABLE dbo.Controls (
   Id BIGINT NOT NULL IDENTITY,
   Name VARCHAR(8000) NOT NULL,
   BaselineID BIGINT NOT NULL,
   FamilyId BIGINT NOT NULL,
   PriorityId BIGINT NOT NULL,
   Description VARCHAR(8000) NOT NULL,
   Guidance VARCHAR(8000) NOT NULL,
   CONSTRAINT PK_Controls PRIMARY KEY (Id),
   CONSTRAINT FK_Controls_Families FOREIGN KEY (FamilyId) REFERENCES dbo.Families (Id),
   CONSTRAINT FK_Controls_Priorities FOREIGN KEY (PriorityId) REFERENCES dbo.Priorities (Id),
   CONSTRAINT FK_Controls_Baselines FOREIGN KEY (BaselineID) REFERENCES dbo.Baselines (Id)
)
GO

-- 
-- Creating a table dbo.Relateds 
-- 
CREATE TABLE dbo.Relateds (
   Id BIGINT NOT NULL IDENTITY,
   ParentId BIGINT NOT NULL,
   ChildId BIGINT NOT NULL,
   CONSTRAINT PK_Relateds PRIMARY KEY (Id),
   CONSTRAINT FK_Relateds_RelatedParent FOREIGN KEY (ParentId) REFERENCES dbo.Controls (Id),
   CONSTRAINT FK_Relateds_IsChild FOREIGN KEY (ChildId) REFERENCES dbo.Controls (Id)
)
GO

-- 
-- Creating a table dbo.Specs 
-- 
CREATE TABLE dbo.Specs (
   Id BIGINT NOT NULL IDENTITY,
   ControId BIGINT NOT NULL,
   SpecificationlName VARCHAR(8000) NOT NULL,
   Description VARCHAR(8000) NOT NULL,
   Guidance VARCHAR(8000) NOT NULL,
   CONSTRAINT PK_Specs PRIMARY KEY (Id),
   CONSTRAINT FK_Specs_Controls FOREIGN KEY (ControId) REFERENCES dbo.Controls (Id)
)
GO

-- 
-- Creating a table dbo.BaselineSecurityMappings 
-- 
CREATE TABLE dbo.BaselineSecurityMappings (
   Id BIGINT NOT NULL IDENTITY,
   Level BIGINT NOT NULL,
   BaselineAuthor BIGINT NOT NULL,
   IsControlMap BIT NOT NULL,
   SpecsId BIGINT NOT NULL,
   ControlsId BIGINT NOT NULL,
   CONSTRAINT PK_BaselineSecurityMappings PRIMARY KEY (Id),
   CONSTRAINT FK_BaselineSecurityMappings_Controls FOREIGN KEY (ControlsId) REFERENCES dbo.Controls (Id),
   CONSTRAINT FK_BaselineSecurityMappings_Specs FOREIGN KEY (SpecsId) REFERENCES dbo.Specs (Id)
)
GO

-- 
-- Creating a table dbo.MapTypesCapabilitiesControls 
-- 
CREATE TABLE dbo.MapTypesCapabilitiesControls (
   Id BIGINT NOT NULL IDENTITY,
   CapabilitiesId BIGINT NOT NULL,
   ControlsId BIGINT NOT NULL,
   MapTypesId BIGINT NOT NULL,
   specId BIGINT NOT NULL,
   isControlMap BIT NOT NULL,
   CONSTRAINT PK_MapTypesCapabilitiesControls PRIMARY KEY (Id),
   CONSTRAINT FK_MapTypesCapabilitiesControls_CapabilitiesImplementation FOREIGN KEY (CapabilitiesId) REFERENCES dbo.Capabilities (Id) ON DELETE CASCADE,
   CONSTRAINT FK_MapTypesCapabilitiesControls_ControlsImplementation FOREIGN KEY (ControlsId) REFERENCES dbo.Controls (Id) ON DELETE CASCADE,
   CONSTRAINT FK_MapTypesCapabilitiesControls_Specs FOREIGN KEY (specId) REFERENCES dbo.Specs (Id)
)
GO

