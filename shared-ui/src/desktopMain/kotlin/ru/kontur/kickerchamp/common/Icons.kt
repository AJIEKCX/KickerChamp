package ru.kontur.kickerchamp.common

import androidx.compose.material.Icon
import androidx.compose.material.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.rememberVectorPainter
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.res.loadXmlImageVector
import androidx.compose.ui.res.useResource
import org.xml.sax.InputSource

@Composable
internal actual fun IncrementIcon(modifier: Modifier) {
    val density = LocalDensity.current
    val painter = rememberVectorPainter(
        remember {
            useResource("ic_increment.xml") { loadXmlImageVector(InputSource(it), density) }
        }
    )
    Icon(
        painter = painter,
        contentDescription = null,
        tint = MaterialTheme.colors.onBackground,
        modifier = modifier
    )
}

@Composable
internal actual fun DefenderIcon() {
    val density = LocalDensity.current
    val painter = rememberVectorPainter(
        remember {
            useResource("ic_defender.xml") { loadXmlImageVector(InputSource(it), density) }
        }
    )
    Icon(
        painter = painter,
        contentDescription = null
    )
}

@Composable
internal actual fun ForwardIcon() {
    val density = LocalDensity.current
    val painter = rememberVectorPainter(
        remember {
            useResource("ic_forward.xml") { loadXmlImageVector(InputSource(it), density) }
        }
    )
    Icon(
        painter = painter,
        contentDescription = null
    )
}