import 'dart:io';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../models/apiary_model.dart';
import 'add_apiary_screen.dart';
import 'apiary_detail_screen.dart';

class ApiariesScreen extends StatefulWidget {
  const ApiariesScreen({super.key});

  @override
  State<ApiariesScreen> createState() => _ApiariesScreenState();
}

class _ApiariesScreenState extends State<ApiariesScreen> {
  final List<Apiary> _apiaries = [];

  void _addApiary(Apiary apiary) {
    setState(() {
      _apiaries.add(apiary);
    });
  }

  void _deleteApiary(String id) {
    setState(() {
      _apiaries.removeWhere((a) => a.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.apiaries),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: _apiaries.isEmpty
          ? _buildEmptyState(l10n)
          : _buildApiariesList(l10n),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddApiaryScreen(),
            ),
          );
          if (result != null && result is Apiary) {
            _addApiary(result);
          }
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🏠', style: TextStyle(fontSize: 80)),
          const SizedBox(height: 16),
          Text(
            l10n.noApiaries,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.addFirstApiary,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApiariesList(AppLocalizations l10n) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _apiaries.length,
      itemBuilder: (context, index) {
        final apiary = _apiaries[index];
        return _buildApiaryCard(apiary, l10n);
      },
    );
  }

  Widget _buildApiaryCard(Apiary apiary, AppLocalizations l10n) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ApiaryDetailScreen(apiary: apiary),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            if (apiary.hasImage)
              SizedBox(
                height: 150,
                width: double.infinity,
                child: Image.file(
                  File(apiary.imageUrl!),
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                height: 100,
                width: double.infinity,
                color: AppColors.primary.withOpacity(0.15),
                child: const Center(
                  child: Text('🏠', style: TextStyle(fontSize: 40)),
                ),
              ),

            // Info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          apiary.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (apiary.hasLocation)
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 16,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  apiary.locationString,
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 12,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Text('🐝', style: TextStyle(fontSize: 14)),
                            const SizedBox(width: 4),
                            Text(
                              '${apiary.hiveCount} ${l10n.hives}',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _showDeleteDialog(apiary, l10n);
                    },
                    icon: Icon(
                      Icons.delete_outline,
                      color: AppColors.error,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(Apiary apiary, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteApiary),
        content: Text('${l10n.deleteApiaryConfirm} "${apiary.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              _deleteApiary(apiary.id);
              Navigator.pop(context);
            },
            child: Text(
              l10n.delete,
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}