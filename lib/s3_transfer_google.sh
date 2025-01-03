#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# shellcheck disable=SC2006

# Transfer file to Google S3.
# Arguments:
#   string source: source file or empty for testing connection
#   string bucket: bucket name
#   string token: bearer token
# Returns:
#   boolean: true on success
#            false on fail
_s3_transfer_google()
{
  __s3g_source="${1:-}"
  __s3g_bucket="${2:-}"
  __s3g_token="${3:-}"
  __s3g_test_connectivity_mode=false

  if [ -z "${__s3g_source}" ]; then
    __s3g_test_connectivity_mode=true
    __s3g_source="transfer_test_from_uac.txt"
  fi

  __s3g_date=`date "+%a, %d %b %Y %H:%M:%S %z"`
	__s3g_content_type="application/octet-stream"
  __s3g_host="storage.googleapis.com"
  __s3g_authorization="Bearer ${__s3g_token}"
  __s3g_url="https://${__s3g_host}/${__s3g_bucket}/${__s3g_source}"

  _http_transfer \
    "${__s3g_source}" \
    "${__s3g_url}" \
    "${__s3g_host}" \
    "${__s3g_date}" \
    "${__s3g_content_type}" \
    "${__s3g_authorization}" \
    "${__s3g_test_connectivity_mode}"

}
