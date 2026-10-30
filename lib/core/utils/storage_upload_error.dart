String friendlyStorageUploadError(
  Object error, {
  required String assetLabel,
  required String bucket,
}) {
  final raw = error.toString();
  final normalized = raw.toLowerCase();

  if (normalized.contains('bucket not found') ||
      normalized.contains('not found') && normalized.contains(bucket)) {
    return 'Could not upload $assetLabel because the bucket `$bucket` does not exist in Supabase Storage.';
  }

  if (normalized.contains('row-level security') ||
      normalized.contains('permission') ||
      normalized.contains('not allowed') ||
      normalized.contains('unauthorized')) {
    return 'Could not upload $assetLabel because Storage policies do not allow writing to `$bucket`.';
  }

  if (normalized.contains('mime') || normalized.contains('content type')) {
    return 'Could not upload $assetLabel because the bucket `$bucket` does not accept that file type.';
  }

  if (normalized.contains('too large') ||
      normalized.contains('payload too large') ||
      normalized.contains('entity too large')) {
    return 'Could not upload $assetLabel because the file exceeds the allowed Storage limit.';
  }

  return 'Could not upload $assetLabel. Detail: $raw';
}
