import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart'; // PagedCustomers, CustomerStatus
import 'package:smartmetric_case/feature/repo/customer_repository.dart';
import 'package:smartmetric_case/product/utility/constant/enums/status_filter.dart';
import 'package:smartmetric_case/product/utility/response/api_response.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _repo = CustomerRepository();
  late Future<ApiResponse<PagedCustomers>> _future;

  StatusFilter _filter = StatusFilter.general;
  final _searchCtrl = TextEditingController();
  Timer? _debounce;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _load();
    _searchCtrl.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _query = _searchCtrl.text.trim();
      _load();
    });
  }

  void _load() {
    _future = _repo.getCustomers(
      status: _mapFilterToCustomerStatus(_filter),
      query: _query.isEmpty
          ? null
          : _query, // sadece isme göre filtre (repo tarafı böyle)
    );
    setState(() {});
  }

  CustomerStatus? _mapFilterToCustomerStatus(StatusFilter f) {
    switch (f) {
      case StatusFilter.general:
        return null;
      case StatusFilter.active:
        return CustomerStatus.active;
      case StatusFilter.passive:
        return CustomerStatus.inactive;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Smartmetrics')),
      body: Column(
        children: [
          // ---- üst şerit: Status (solda) + Arama (sağda) ----
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: [
                StatusMenu(
                  value: _filter,
                  onSelected: (v) {
                    _filter = v;
                    _load();
                  },
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _SearchField(
                    controller: _searchCtrl,
                    onClear: () {
                      _searchCtrl.clear(); // listener tetikler, _load çağrılır
                    },
                  ),
                ),
              ],
            ),
          ),

          // ---- liste ----
          Expanded(
            child: FutureBuilder<ApiResponse<PagedCustomers>>(
              future: _future,
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snap.hasData) return const Center(child: Text('Veri yok'));
                final api = snap.data!;
                if (api.error != null) {
                  return Center(child: Text('Hata: ${api.error}'));
                }
                final items = api.data!.data;
                if (items.isEmpty) {
                  return const Center(child: Text('Kayıt bulunamadı'));
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) {
                    final c = items[i];
                    return UserStatusTile(
                      name: c.name,
                      email: c.email,
                      isActive: c.status == CustomerStatus.active,
                      onTap: () {},
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ---- Solda küçük ok + "status" butonu ----
class StatusMenu extends StatelessWidget {
  const StatusMenu({
    super.key,
    required this.value,
    required this.onSelected,
  });

  final StatusFilter value;
  final ValueChanged<StatusFilter> onSelected;

  @override
  Widget build(BuildContext context) {
    final border = Theme.of(context).dividerColor;

    return PopupMenuButton<StatusFilter>(
      initialValue: value,
      onSelected: onSelected,
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      itemBuilder: (ctx) => const [
        PopupMenuItem(value: StatusFilter.general, child: Text('general')),
        PopupMenuItem(value: StatusFilter.active, child: Text('active')),
        PopupMenuItem(value: StatusFilter.passive, child: Text('passive')),
      ],
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.keyboard_arrow_down_rounded, size: 18),
            SizedBox(width: 6),
            Text('status', style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

// ---- Arama inputu (pill görünüm) ----
class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.onClear,
  });

  final TextEditingController controller;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final border = Theme.of(context).dividerColor;

    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                hintText: 'search name...', // sadece isme göre
                border: InputBorder.none,
                isCollapsed: true,
              ),
              onSubmitted: (_) {}, // debounce zaten var
              autocorrect: false,
            ),
          ),
          // clear ikonunu anında güncellemek için
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (_, value, __) {
              if (value.text.isEmpty) return const SizedBox.shrink();
              return GestureDetector(
                onTap: onClear,
                child: const Icon(Icons.close, size: 18),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ---- Liste elemanı (seninki) ----
class UserStatusTile extends StatelessWidget {
  const UserStatusTile({
    super.key,
    required this.name,
    required this.email,
    required this.isActive,
    this.onTap,
  });

  final String name;
  final String email;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bg = Theme.of(context).cardColor;
    final border = Theme.of(context).dividerColor;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: border),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.color
                                ?.withOpacity(0.7),
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              _StatusPill(isActive: isActive),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.isActive});
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final fg = isActive ? Colors.green.shade700 : Colors.red.shade700;
    final bg = (isActive ? Colors.green : Colors.red).withOpacity(0.12);
    final label = isActive ? 'active' : 'passive';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: fg.withOpacity(0.25)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: fg,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
      ),
    );
  }
}
