import 'dart:convert';
import 'package:flutter/services.dart';


/// Model for project feature
class ProjectFeature {
  final String title;
  final String? description;

  ProjectFeature({required this.title, this.description});

  factory ProjectFeature.fromJson(Map<String, dynamic> json) {
    return ProjectFeature(
      title: json['title'] as String,
      description: json['description'] as String?,
    );
  }
}

/// Model for project stats
class ProjectStat {
  final String value;
  final String label;

  ProjectStat({required this.value, required this.label});

  factory ProjectStat.fromJson(Map<String, dynamic> json) {
    return ProjectStat(
      value: json['value'] as String,
      label: json['label'] as String,
    );
  }
}

/// Model for project external links
class ProjectLink {
  final String label;
  final String url;
  final LinkType type;

  ProjectLink({required this.label, required this.url, required this.type});

  factory ProjectLink.fromJson(Map<String, dynamic> json) {
    return ProjectLink(
      label: json['label'] as String,
      url: json['url'] as String,
      type: _parseLinkType(json['type'] as String),
    );
  }
}

enum LinkType { github, demo, website }

LinkType _parseLinkType(String type) {
  return LinkType.values.firstWhere(
    (e) => e.toString().split('.').last == type,
    orElse: () => LinkType.github,
  );
}

/// Complete project model
class ProjectModel {
  final String id;
  final String title;
  final String description;
  final String imageAsset;
  final List<ProjectFeature> features;
  final List<String> technologies;
  final List<ProjectStat> stats;
  final List<ProjectLink> links;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageAsset,
    required this.features,
    required this.technologies,
    required this.stats,
    required this.links,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageAsset: json['imageAsset'] as String,
      features: (json['features'] as List<dynamic>)
          .map((e) => ProjectFeature.fromJson(e as Map<String, dynamic>))
          .toList(),
      technologies: List<String>.from(json['technologies'] as List<dynamic>),
      stats: (json['stats'] as List<dynamic>)
          .map((e) => ProjectStat.fromJson(e as Map<String, dynamic>))
          .toList(),
      links: (json['links'] as List<dynamic>)
          .map((e) => ProjectLink.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

// Load projects from JSON file
Future<List<ProjectModel>> loadAllProjects() async {
  try {
    final jsonString = await rootBundle.loadString('assets/datalist/achievements_list.json');
    if (jsonString.isEmpty) {
      throw Exception('JSON file is empty');
    }
    final List<dynamic> jsonList = jsonDecode(jsonString);
    if (jsonList.isEmpty) {
      throw Exception('JSON list is empty');
    }
    return jsonList
        .map((item) => ProjectModel.fromJson(item as Map<String, dynamic>))
        .toList();
  } catch (e) {
    rethrow;
  }
}

Future<ProjectModel> loadClassTrackingProject() async {
  try {
    final jsonString = await rootBundle.loadString('assets/datalist/achievements_list.json');
    if (jsonString.isEmpty) {
      throw Exception('JSON file is empty');
    }
    final List<dynamic> jsonList = jsonDecode(jsonString);
    if (jsonList.isEmpty) {
      throw Exception('JSON list is empty');
    }
    return ProjectModel.fromJson(jsonList.first as Map<String, dynamic>);
  } catch (e) {
    rethrow;
  }
}

// Cached project data
List<ProjectModel>? _allProjects;
ProjectModel? _classTrackingProject;

Future<List<ProjectModel>> getAllProjects() async {
  _allProjects ??= await loadAllProjects();
  return _allProjects!;
}

Future<ProjectModel> getClassTrackingProject() async {
  _classTrackingProject ??= await loadClassTrackingProject();
  return _classTrackingProject!;
}

// For backward compatibility
final Future<ProjectModel> classTrackingProjectFuture = loadClassTrackingProject();
