import 'package:flutter/material.dart';
import '../../model/history.dart';
import '../../model/recommendation.dart';

class HistoryCard extends StatefulWidget {
  final History historyItem;
  final Recommendation recommendation;

  const HistoryCard({
    Key? key,
    required this.historyItem,
    required this.recommendation,
  }) : super(key: key);

  @override
  _EnhancedHistoryCardState createState() => _EnhancedHistoryCardState();
}

class _EnhancedHistoryCardState extends State<HistoryCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.blueGrey.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatDate(
                            widget.historyItem.detectionDate ?? DateTime.now()),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey.shade500,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.historyItem.recommendation?.skinCondition
                                ?.conditionName ??
                            'Kondisi Kulit Tidak Diketahui',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.blueGrey.shade900,
                          letterSpacing: 0.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.historyItem.recommendation?.skinCondition
                                ?.description ??
                            'Deskripsi Tidak Tersedia',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blueGrey.shade700,
                          height: 1.5,
                        ),
                        maxLines: _isExpanded ? null : 2,
                        overflow: _isExpanded
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: _buildScanImage(),
                  ),
                ),
              ],
            ),
          ),
          if (widget.recommendation.condition.treatments.deskripsi_treatment
              .isNotEmpty)
            _buildTreatmentSection(),
          _buildReadMoreButton(),
        ],
      ),
    );
  }

  Widget _buildScanImage() {
    return widget.historyItem.gambarScan != null &&
            widget.historyItem.gambarScan!.isNotEmpty
        ? Image.network(
            widget.historyItem.gambarScan!,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.blueGrey.shade200),
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          (loadingProgress.expectedTotalBytes ?? 1)
                      : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 100,
                height: 100,
                color: Colors.blueGrey.shade100,
                child: Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                    color: Colors.blueGrey.shade300,
                    size: 50,
                  ),
                ),
              );
            },
          )
        : Container(
            width: 100,
            height: 100,
            color: Colors.blueGrey.shade100,
            child: Center(
              child: Icon(
                Icons.image_not_supported,
                color: Colors.blueGrey.shade300,
                size: 50,
              ),
            ),
          );
  }

  Widget _buildTreatmentSection() {
    return AnimatedCrossFade(
      firstChild: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Colors.blueGrey.shade50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Treatment',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey.shade800,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.recommendation.condition.treatments.deskripsi_treatment,
              style: TextStyle(
                fontSize: 14,
                color: Colors.blueGrey.shade600,
                height: 1.5,
              ),
              maxLines: _isExpanded ? null : 2,
              overflow:
                  _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      secondChild: const SizedBox.shrink(),
      crossFadeState:
          _isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 300),
    );
  }

  Widget _buildReadMoreButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade50,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Center(
          child: Text(
            _isExpanded ? 'Tutup' : 'Baca Selengkapnya',
            style: TextStyle(
              color: Colors.blueGrey.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return "${date.day} ${months[date.month - 1]} ${date.year}";
  }
}
