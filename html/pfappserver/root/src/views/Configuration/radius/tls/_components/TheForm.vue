<template>
  <base-form
    :form="form"
    :meta="meta"
    :schema="schema"
    :isLoading="isLoading"
  >
    <form-group-identifier namespace="id"
      :column-label="$i18n.t('Identifier')"
      :disabled="!isNew && !isClone"
    />

    <form-group-certificate-profile namespace="certificate_profile"
      :column-label="$i18n.t('Certificate Profile')"
    />

    <form-group-dh-file namespace="dh_file"
      :column-label="$i18n.t('DH File')"
    />

    <form-group-ca-path namespace="ca_path"
      :column-label="$i18n.t('CA Path')"
    />

    <form-group-cipher-list namespace="cipher_list"
      :column-label="$i18n.t('Cipher List')"
    />

    <form-group-ecdh-curve namespace="ecdh_curve"
      :column-label="$i18n.t('ECDH Curve')"
    />

    <form-group-tls-min-version namespace="tls_min_version"
      :column-label="$i18n.t('TLS Minimum version')"
    />

    <form-group-tls-max-version namespace="tls_max_version"
      :column-label="$i18n.t('TLS Maximum version')"
    />

    <form-group-ocsp namespace="ocsp"
      :column-label="$i18n.t('OCSP Profile')"
    />
  </base-form>
</template>
<script>
import { computed } from '@vue/composition-api'
import {
  BaseForm
} from '@/components/new/'
import schemaFn from '../schema'
import {
  FormGroupIdentifier,
  FormGroupCertificateProfile,
  FormGroupDhFile,
  FormGroupCaPath,
  FormGroupCipherList,
  FormGroupEcdhCurve,
  FormGroupTlsMinVersion,
  FormGroupTlsMaxVersion,
  FormGroupOcsp
} from './'

const components = {
  BaseForm,

  FormGroupIdentifier,
  FormGroupCertificateProfile,
  FormGroupDhFile,
  FormGroupCaPath,
  FormGroupCipherList,
  FormGroupEcdhCurve,
  FormGroupTlsMinVersion,
  FormGroupTlsMaxVersion,
  FormGroupOcsp
}

export const props = {
  id: {
    type: String
  },
  form: {
    type: Object
  },
  meta: {
    type: Object
  },
  isNew: {
    type: Boolean,
    default: false
  },
  isClone: {
    type: Boolean,
    default: false
  },
  isLoading: {
    type: Boolean,
    default: false
  }
}

export const setup = (props) => {
  const schema = computed(() => schemaFn(props))

  return {
    schema
  }
}

// @vue/component
export default {
  name: 'the-form',
  inheritAttrs: false,
  components,
  props,
  setup
}
</script>
