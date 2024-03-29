#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
typedef struct _Dart_Handle* Dart_Handle;

#define ONE_MB (1024 * 1024)

#define AES_ENCRYPT_ONE_MB 1048592

#define SIXTEEN_MB (16 * ONE_MB)

#define TYPE_KEY 0

#define TYPE_DECRYPT 1

#define TYPE_ENCRYPT 2

#define TYPE_ZIP_FILE 3

#define TYPE_TRANSFER 4

typedef struct DartCObject DartCObject;

typedef int64_t DartPort;

typedef bool (*DartPostCObjectFnType)(DartPort port_id, void *message);

typedef struct wire_uint_8_list {
  uint8_t *ptr;
  int32_t len;
} wire_uint_8_list;

typedef struct wire_EncryptItem {
  struct wire_uint_8_list *file_path;
  int64_t file_id;
} wire_EncryptItem;

typedef struct wire_list_encrypt_item {
  struct wire_EncryptItem *ptr;
  int32_t len;
} wire_list_encrypt_item;

typedef struct wire_StringList {
  struct wire_uint_8_list **ptr;
  int32_t len;
} wire_StringList;

typedef struct DartCObject *WireSyncReturn;

void store_dart_post_cobject(DartPostCObjectFnType ptr);

Dart_Handle get_dart_object(uintptr_t ptr);

void drop_dart_object(uintptr_t ptr);

uintptr_t new_dart_opaque(Dart_Handle handle);

intptr_t init_frb_dart_api_dl(void *obj);

void wire_test_encrypt(int64_t port_);

void wire_native_message_stream(int64_t port_);

void wire_default_key(int64_t port_);

void wire_random_key(int64_t port_);

void wire_encrypt(int64_t port_,
                  struct wire_uint_8_list *save_dir,
                  struct wire_list_encrypt_item *files,
                  struct wire_uint_8_list *key);

void wire_compress(int64_t port_, struct wire_StringList *paths, struct wire_uint_8_list *save_dir);

void wire_flow_preview(int64_t port_, struct wire_StringList *operators);

void wire_init_s3_client(int64_t port_,
                         struct wire_uint_8_list *endpoint,
                         struct wire_uint_8_list *bucketname,
                         struct wire_uint_8_list *access_key,
                         struct wire_uint_8_list *session_key,
                         struct wire_uint_8_list *session_token,
                         struct wire_uint_8_list *region);

void wire_upload_to_s3(int64_t port_, struct wire_uint_8_list *p, struct wire_uint_8_list *obj);

void wire_upload_to_s3_with_config(int64_t port_,
                                   struct wire_uint_8_list *endpoint,
                                   struct wire_uint_8_list *bucketname,
                                   struct wire_uint_8_list *access_key,
                                   struct wire_uint_8_list *session_key,
                                   struct wire_uint_8_list *session_token,
                                   struct wire_uint_8_list *region,
                                   struct wire_uint_8_list *p,
                                   struct wire_uint_8_list *obj);

void wire_download_from_s3(int64_t port_, struct wire_uint_8_list *p, struct wire_uint_8_list *obj);

void wire_generate_pregisn_url(int64_t port_,
                               struct wire_uint_8_list *endpoint,
                               struct wire_uint_8_list *bucketname,
                               struct wire_uint_8_list *access_key,
                               struct wire_uint_8_list *session_key,
                               struct wire_uint_8_list *session_token,
                               struct wire_uint_8_list *region,
                               struct wire_uint_8_list *obj);

struct wire_StringList *new_StringList_0(int32_t len);

struct wire_list_encrypt_item *new_list_encrypt_item_0(int32_t len);

struct wire_uint_8_list *new_uint_8_list_0(int32_t len);

void free_WireSyncReturn(WireSyncReturn ptr);

static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) wire_test_encrypt);
    dummy_var ^= ((int64_t) (void*) wire_native_message_stream);
    dummy_var ^= ((int64_t) (void*) wire_default_key);
    dummy_var ^= ((int64_t) (void*) wire_random_key);
    dummy_var ^= ((int64_t) (void*) wire_encrypt);
    dummy_var ^= ((int64_t) (void*) wire_compress);
    dummy_var ^= ((int64_t) (void*) wire_flow_preview);
    dummy_var ^= ((int64_t) (void*) wire_init_s3_client);
    dummy_var ^= ((int64_t) (void*) wire_upload_to_s3);
    dummy_var ^= ((int64_t) (void*) wire_upload_to_s3_with_config);
    dummy_var ^= ((int64_t) (void*) wire_download_from_s3);
    dummy_var ^= ((int64_t) (void*) wire_generate_pregisn_url);
    dummy_var ^= ((int64_t) (void*) new_StringList_0);
    dummy_var ^= ((int64_t) (void*) new_list_encrypt_item_0);
    dummy_var ^= ((int64_t) (void*) new_uint_8_list_0);
    dummy_var ^= ((int64_t) (void*) free_WireSyncReturn);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    dummy_var ^= ((int64_t) (void*) get_dart_object);
    dummy_var ^= ((int64_t) (void*) drop_dart_object);
    dummy_var ^= ((int64_t) (void*) new_dart_opaque);
    return dummy_var;
}
